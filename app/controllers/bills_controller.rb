class BillsController < ApplicationController
  load_and_authorize_resource find_by: :sequence_num, through: :current_hospital
  before_action :root_page_breadcrumb, only: [:index, :new, :show, :edit]
  before_action :index_page_breadcrumb, only: [:index, :new, :show, :edit]
  before_action :show_page_breadcrumb, only: [:show]

  def index
    @bills = @bills.paginate(page: params[:page], per_page: 5)
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

  def addmed
    @medicine= Medicine.find_by(id: params[:medicine_id])
    quantity=params[:quantity].to_i
    if @bill.add_medicine(@medicine,quantity) 
      flash[:notice] = t('sales_order.addmed.success')  
      respond_to do |format|
        format.js{ render 'bills/update_price' }
      end            
    else   
      flash[:error] = [t('sales_order.addmed.failure')]
      flash[:error] += @bill.errors.full_messages      
    end 
  end

  def adddoc
    @doctor= Doctor.find_by(id: params[:doctor_id])
    if @bill.add_doctor(@doctor) 
      flash[:notice] = t('sales_order.addmed.success')  
      respond_to do |format|
        format.js{ render 'bills/update_price' }
      end            
    else   
      flash[:error] = [t('sales_order.addmed.failure')]
      flash[:error] += @bill.errors.full_messages      
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
      flash[:error] += @bill.errors.full_messages    
    end
  end

  def update
    if @bill.update_attributes(bill_params)  
      flash[:notice] = t('sales_order.update.success') 
      redirect_to @bill        
    else   
      flash[:error] = [t('sales_order.update.failure')]
      flash[:error] += @bill.errors.full_messages     
    end   
  end

  def destroy   
    if @bill.destroy 
      flash[:notice] = t('sales_order.delete.success')  
      redirect_to bills_path    
    else   
      flash[:error] = [t('sales_order.delete.failure')]
      flash[:error] += @bill.errors.full_messages   
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
