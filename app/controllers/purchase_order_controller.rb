class PurchaseOrderController < ApplicationController
  before_action :load_purchase_order, only: :show
  load_and_authorize_resource find_by: :sequence_num, through: :current_hospital

  before_action :index_page_breadcrumb, only: %i[index new show edit]
  before_action :show_page_breadcrumb, only: [:show]

  # GET /purchase_order
  def index
    @purchase_orders = @purchase_orders.paginate(page: params[:page], per_page: PAGINATION_SIZE)
    respond_to do |format|
      format.html
    end
  end

  # GET /purchase_order/new
  def new
    add_breadcrumb t('purchase_order.breadcrumb.new'), new_purchase_order_path
    respond_to do |format|
      format.html
    end
  end

  # GET /purchase_order/:id/get_medicine
  def get_medicine
    @medicine = current_hospital.medicines.find_by(id: params[:search])
    if @medicine.blank?
      flash[:notice] = t('medicine.search.failure')
    else
      respond_to do |format|
        format.js { render 'search' }
      end
    end
  end

  # PUT /purchase_order/:id/add_medicine
  def add_medicine
    @medicine = current_hospital.medicines.find_by(id: params[:medicine_id])
    quantity = params[:quantity].to_i
    if @purchase_order.add_medicine(@medicine, quantity)
        flash[:notice] = t('purchase_order.addmed.success')
    else
      flash[:error] = [t('purchase_order.addmed.failure')]
      flash[:error] += @purchase_order.errors.full_messages if @purchase_order.errors.full_messages.present?
    end
    respond_to do |format|
      format.js { render 'purchase_order/update_price' }
    end
  end

  # POST /purchase_order/:id/add_medicine
  def remove_medicine
    @medicine = current_hospital.medicines.find_by(id: params[:medicine_id])
    if @purchase_order.remove_medicine(@medicine)
      respond_to do |format|
        flash[:notice] = t('purchase_order.remove_medicine.success')
        format.js { render 'purchase_order/update_price' }
      end
    else
      flash[:error] = [t('purchase_order.remove_medicine.failure')]
      flash[:error] += @purchase_order.errors.full_messages if @purchase_order.errors.full_messages.present?
      redirect_to(request.env['HTTP_REFERER'])
    end
  end

  # GET /purchase_order/:id
  def show
    respond_to do |format|
      format.html
    end
  end

  # GET /purchase_order/:id/edit
  def edit
    add_breadcrumb t('purchase_order.breadcrumb.edit'), edit_purchase_order_path
    respond_to do |format|
      format.html
    end
  end

  # POST /purchase_order
  def create
    @purchase_order.hospital = current_hospital
    @purchase_order.admin = current_user
    if @purchase_order.save
      flash[:notice] = t('purchase_order.add.success')
      redirect_to @purchase_order
    else
      flash[:error] = [t('purchase_order.add.failure')]
      flash[:error] += @purchase_order.errors.full_messages if @purchase_order.errors.full_messages.present?
      redirect_to(request.env['HTTP_REFERER'])
    end
  end

  # PATCH purchase_order /:id
  def update
    if @purchase_order.update_attributes(purchase_order_params)
      flash[:notice] = t('purchase_order.update.success')
      redirect_to @purchase_order
    else
      flash[:error] = [t('purchase_order.update.failure')]
      flash[:error] += @purchase_order.errors.full_messages if @purchase_order.errors.full_messages.present?
      redirect_to(request.env['HTTP_REFERER'])
    end
  end

  # DELETE purchase_order /:id
  def destroy
    if @purchase_order.destroy
      flash[:notice] = t('purchase_order.delete.success')
      redirect_to purchase_order_index_path
    else
      flash[:error] = [t('purchase_order.delete.failure')]
      flash[:error] += @purchase_order.errors.full_messages if @purchase_order.errors.full_messages.present?
      redirect_to(request.env['HTTP_REFERER'])
    end
  end

  # PUT /purchase_order/:id/confirm
  def confirm
    if @purchase_order.confirm!
      flash[:notice] = t('purchase_order.confirm.success')
      redirect_to @purchase_order
    else
      flash[:error] = [t('purchase_order.confirm.failure')]
      flash[:error] += @purchase_order.errors.full_messages if @purchase_order.errors.full_messages.present?
      redirect_to(request.env['HTTP_REFERER'])
    end
  end

  # PUT /purchase_order/:id/deliver
  def deliver
    @purchase_order.purchase_details.each do |purchasedetail|
      purchasedetail.medicine.update(quantity: purchasedetail.medicine.quantity + purchasedetail.quantity)
    end
    if @purchase_order.deliver!
      flash[:notice] = t('purchase_order.deliver.success')
      redirect_to @purchase_order
    else
      flash[:error] = [t('purchase_order.deliver.failure')]
      flash[:error] += @purchase_order.errors.full_messages if @purchase_order.errors.full_messages.present?
      redirect_to(request.env['HTTP_REFERER'])
    end
  end

  def purchase_order_params   
    params.require(:purchase_order).permit(:vendorname, :price)
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

  def load_purchase_order
    @purchase_order = PurchaseOrder.includes(purchase_details: :medicine).find_by(sequence_num: params[:id])
  end
end
