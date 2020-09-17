class PurchaseOrderController < ApplicationController
  load_and_authorize_resource find_by: :sequence_num, through: :current_hospital

  def index    
  end

  def new
  end

  def addmed
    @medicine= Medicine.find_by(id: params[:medicine_id])
    quantity=params[:quantity].to_i
    if @purchase_order.add_medicine(@medicine,quantity) 
      flash[:notice] = t('purchase_order.addmed.success')  
      respond_to do |format|
        format.js{ render 'purchase_order/update_price' }
      end            
    else   
      flash[:error] = t('purchase_order.addmed.failure')     
    end 
  end

  def show
  end

  def edit
  end

  def create
    @purchase_order.hospital=current_hospital 
    @purchase_order.admin=current_user
    if @purchase_order.save!  
      flash[:notice] = t('purchase_order.add.success')   
      redirect_to @purchase_order
    else   
      flash[:error] = t('purchase_order.add.failure')    
    end
  end

  def update
    if @purchase_order.update_attributes(purchase_order_params)  
      flash[:notice] = t('purchase_order.update.success') 
      redirect_to @purchase_order        
    else   
      flash[:error] = t('purchase_order.update.failure')     
    end   
  end

  def destroy   
    if @purchase_order.destroy 
      flash[:notice] = t('purchase_order.delete.success')  
      redirect_to purchase_order_index_path    
    else   
      flash[:error] = t('purchase_order.delete.failure')   
    end
  end

  def purchase_order_params   
    params.require(:purchase_order).permit(:vendorname, :price, :state)   
  end

end
