class BillsController < ApplicationController
  before_action :load_bill, only: :show
  load_and_authorize_resource find_by: :sequence_num, through: :current_hospital

  before_action :index_page_breadcrumb, only: %i[index new show edit]
  before_action :show_page_breadcrumb, only: [:show]

  # GET /bills
  def index
    @active_tab = params[:tab] == 'doctor' ? 'doctor' : 'medicine'
    @bills = @bills.includes(:patient)
    @doctor_bills = @bills.where(billable_type: 'doctor').paginate(page: params[:page1], per_page: PAGINATION_SIZE)
    @medicine_bills = @bills.where(billable_type: 'medicine').paginate(page: params[:page2], per_page: PAGINATION_SIZE)
    respond_to do |format|
      format.html
    end
  end

  # GET /bills/new
  def new
    add_breadcrumb t('sales_order.breadcrumb.new'), new_bill_path
    respond_to do |format|
      format.html
    end
  end
  
  def get_medicine
    @medicine = current_hospital.medicines.find_by(id: params[:search])
    if @medicine.blank?
      flash[:notice] = t('medicine.search.failure')
      redirect_to(request.env['HTTP_REFERER'])
    else
      respond_to do |format|
        format.js { render 'searchmed' }
      end
    end
  end

  def add_medicine
    @medicine = current_hospital.medicines.find_by(id: params[:medicine_id])
    quantity = params[:quantity].to_i
    if @bill.add_medicine(@medicine, quantity)
      flash.now[:notice] = t('sales_order.addmed.success')
    else
      flash.now[:error] = [t('sales_order.addmed.failure')]
      flash.now[:error] += @bill.errors.full_messages if @bill.errors.full_messages.present?
    end
    respond_to do |format|
      format.js { render 'bills/update_price' }
    end
  end

  def add_doctor
    @doctor = current_hospital.doctors.find_by(id: params[:doctor_id])
    if @bill.add_doctor(@doctor)
      respond_to do |format|
        flash[:notice] = [t('sales_order.adddoc.success')]
        format.js { render 'bills/update_price' }
      end
    else
      flash[:error] = [t('sales_order.adddoc.failure')]
      flash[:error] += @bill.errors.full_messages @bill.errors.full_messages.present?
      respond_to do |format|
        format.js { render 'bills/dont_update_price' }
      end
    end
  end

  # GET /bills/:id
  def show
    respond_to do |format|
      format.html
    end
  end

  # GET /bills/:id/edit
  def edit
    add_breadcrumb t('sales_order.breadcrumb.edit'), edit_bill_path
    respond_to do |format|
      format.html
    end
  end

  # POST /bills
  def create
    if @bill.save
      flash[:notice] = t('sales_order.add.success')
      redirect_to @bill
    else
      flash[:error] = [t('sales_order.add.failure')]
      flash[:error] += @bill.errors.full_messages if @bill.errors.full_messages.present?
      redirect_to(request.env['HTTP_REFERER'])
    end
  end

  # PATCH /bills/:id
  def update
    if @bill.update_attributes(bill_params)
      flash[:notice] = t('sales_order.update.success')
      redirect_to @bill
    else
      flash[:error] = [t('sales_order.update.failure')]
      flash[:error] += @bill.errors.full_messages if @bill.errors.full_messages.present?
      redirect_to(request.env['HTTP_REFERER'])
    end
  end

    # DELETE /bills/:id
  def destroy
    if @bill.destroy
      flash[:notice] = t('sales_order.delete.success')
      redirect_to bills_path
    else   
      flash[:error] = [t('sales_order.delete.failure')]
      flash[:error] += @bill.errors.full_messages if @bill.errors.full_messages.present?
      redirect_to(request.env['HTTP_REFERER'])
    end
  end

  def bill_params
    params.require(:bill).permit(:billable_type, :patient_id)
  end

  def root_page_breadcrumb
    add_breadcrumb current_hospital.name, hospital_index_path
  end

  def index_page_breadcrumb
    add_breadcrumb t('sales_order.breadcrumb.index'), bills_path
  end

  def show_page_breadcrumb
    add_breadcrumb t('sales_order.breadcrumb.show'), bill_path
  end

  def load_bill
    @bill = Bill.includes(bill_details: [:billable]).find_by(sequence_num: params[:id])
  end
end
