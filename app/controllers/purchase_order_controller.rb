class PurchaseOrderController < ApplicationController
  load_and_authorize_resource find_by: :sequence_num, through: :current_hospital
  
  before_action :index_page_breadcrumb, only: [:index, :new, :show, :edit]
  before_action :show_page_breadcrumb, only: [:show]

  def index
    @purchase_orders = @purchase_orders.paginate(page: params[:page], per_page: PAGINATION_SIZE )
    respond_to do |format|
      format.html
    end    
  end

  def new
    add_breadcrumb t('purchase_order.breadcrumb.new'), new_purchase_order_path
    respond_to do |format|
      format.html
    end
  end
  
  def get_medicine
    @medicine = current_hospital.medicines.find_by(id: params[:search])
    if @medicine.blank?
      flash[:notice] = t('medicine.search.failure')
    else
      flash[:notice] = t('medicine.search.success')
      respond_to do |format|
          format.js{ render 'search'  }
        end
    end
  end

  def add_medicine
    @medicine= current_hospital.medicines.find_by(id: params[:medicine_id])
    quantity=params[:quantity].to_i
    if @purchase_order.add_medicine(@medicine,quantity) 
      flash[:notice] = t('purchase_order.addmed.success')  
      respond_to do |format|
        format.js{ render 'purchase_order/update_price' }
      end            
    else   
      flash[:error] = [t('purchase_order.addmed.failure')]
      if @purchase_order.errors.full_messages.present?
        flash[:error] += @purchase_order.errors.full_messages
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
    add_breadcrumb t('purchase_order.breadcrumb.edit'), edit_purchase_order_path
    respond_to do |format|
      format.html
    end
  end

  def create
    @purchase_order.hospital=current_hospital 
    @purchase_order.admin=current_user
    if @purchase_order.save!  
      flash[:notice] = t('purchase_order.add.success')   
      redirect_to @purchase_order
    else   
      flash[:error] = [t('purchase_order.add.failure')]
      if @purchase_order.errors.full_messages.present?
        flash[:error] += @purchase_order.errors.full_messages
      end
      redirect_to(request.env['HTTP_REFERER'])     
    end
  end

  def update
    if @purchase_order.update_attributes(purchase_order_params)  
      flash[:notice] = t('purchase_order.update.success') 
      redirect_to @purchase_order        
    else   
      flash[:error] = [t('purchase_order.update.failure')]
      if @purchase_order.errors.full_messages.present?
        flash[:error] += @purchase_order.errors.full_messages
      end
      redirect_to(request.env['HTTP_REFERER'])       
    end   
  end

  def destroy   
    if @purchase_order.destroy 
      flash[:notice] = t('purchase_order.delete.success')  
      redirect_to purchase_order_index_path    
    else   
      flash[:error] = [t('purchase_order.delete.failure')]
      if @purchase_order.errors.full_messages.present?
        flash[:error] += @purchase_order.errors.full_messages
      end
      redirect_to(request.env['HTTP_REFERER'])     
    end
  end

  def confirm
    if @purchase_order.can_confirm?
      @purchase_order.confirm!
      flash[:notice] = t('purchase_order.confirm.success') 
      redirect_to @purchase_order
    else   
      flash[:error] = [t('purchase_order.confirm.failure')]
      if @purchase_order.errors.full_messages.present?
        flash[:error] += @purchase_order.errors.full_messages
      end
      redirect_to(request.env['HTTP_REFERER'])     
    end
  end

  def deliver
    if @purchase_order.can_deliver?
      @purchase_order.deliver!
      flash[:notice] = t('purchase_order.deliver.success') 
      redirect_to @purchase_order
    else   
      flash[:error] = [t('purchase_order.deliver.failure')]
      if @purchase_order.errors.full_messages.present?
        flash[:error] += @purchase_order.errors.full_messages
      end
      redirect_to(request.env['HTTP_REFERER'])     
    end
  end

  def purchase_order_params   
    params.require(:purchase_order).permit(:vendorname, :price, :state)   
  end

  def root_page_breadcrumb
    add_breadcrumb current_hospital.name, hospital_index_path
  end

  def index_page_breadcrumb
    add_breadcrumb t('purchase_order.breadcrumb.index'), purchase_order_index_path
  end

  def show_page_breadcrumb
    add_breadcrumb t('purchase_order.breadcrumb.show'), purchase_order_path
  end

end
