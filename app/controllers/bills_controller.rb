class BillsController < ApplicationController
  load_and_authorize_resource find_by: :sequence_num, through: :current_hospital
  before_action :root_page_breadcrumb, only: [:index, :new, :show, :edit]
  before_action :index_page_breadcrumb, only: [:index, :new, :show, :edit]
  before_action :show_page_breadcrumb, only: [:show]

  def index
    @active_tab = params[:tab] == 'doctor' ? 'doctor' : 'medicine'
    @doctor_bills = @bills.where(billable_type:'doctor')
    @doctor_bills = @doctor_bills.paginate(page: params[:page1], per_page: 3)
    @medicine_bills = @bills.where(billable_type:'medicine')
    @medicine_bills = @medicine_bills.paginate(page: params[:page2], per_page: 3)
    respond_to do |format|
      format.html
    end    
  end

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
      flash[:notice] = t('medicine.search.success')
      respond_to do |format|
          format.js{ render 'searchmed'  }
        end
    end
  end

  def add_medicine
    @medicine= current_hospital.medicines.find_by(id: params[:medicine_id])
    quantity=params[:quantity].to_i
    if @bill.add_medicine(@medicine,quantity) 
      flash[:notice] = t('sales_order.addmed.success')  
      respond_to do |format|
        format.js{ render 'bills/update_price' }
      end            
    else  
      flash[:error] = [t('sales_order.addmed.failure')]
      if @bill.errors.full_messages.present?
        flash[:error] += @bill.errors.full_messages
      end
      redirect_to(request.env['HTTP_REFERER'])     
    end 
  end

  def add_doctor
    @doctor= current_hospital.doctors.find_by(id: params[:doctor_id])
    if @bill.add_doctor(@doctor) 
      flash[:notice] = t('sales_order.addmed.success')  
      respond_to do |format|
        format.js{ render 'bills/update_price' }
      end            
    else   
      flash[:error] = [t('sales_order.addmed.failure')]
      if @bill.errors.full_messages.present?
        flash[:error] += @bill.errors.full_messages
      end
      redirect_to(request.env['HTTP_REFERER'])      
    end 
  end

  def show
    respond_to do |format|
      format.html
    end
  end

  def edit
    add_breadcrumb t('sales_order.breadcrumb.edit'), edit_bill_path
    respond_to do |format|
      format.html
    end
  end

  def create
    @bill.hospital=current_hospital
    if @bill.save!  
      flash[:notice] = t('sales_order.add.success')   
      redirect_to @bill
    else   
      flash[:error] = [t('sales_order.add.failure')]
      if @bill.errors.full_messages.present?
        flash[:error] += @bill.errors.full_messages
      end
      redirect_to(request.env['HTTP_REFERER']) 
    end
  end

  def update
    if @bill.update_attributes(bill_params)  
      flash[:notice] = t('sales_order.update.success') 
      redirect_to @bill        
    else   
      flash[:error] = [t('sales_order.update.failure')]
      if @bill.errors.full_messages.present?
        flash[:error] += @bill.errors.full_messages
      end
      redirect_to(request.env['HTTP_REFERER'])      
    end   
  end

  def destroy   
    if @bill.destroy 
      flash[:notice] = t('sales_order.delete.success')  
      redirect_to bills_path    
    else   
      flash[:error] = [t('sales_order.delete.failure')]
      if @bill.errors.full_messages.present?
        flash[:error] += @bill.errors.full_messages
      end
      redirect_to(request.env['HTTP_REFERER'])    
    end
  end

  def bill_params   
    params.require(:bill).permit(:billable_type, :patient_id, :price)   
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

end
