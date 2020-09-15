class PurchaseOrderController < ApplicationController

  def index
    @purchase_orders = PurchaseOrder.all    
  end

  def new
    @purchase_order = PurchaseOrder.new
  end

  def addmed
    @purchase_order = PurchaseOrder.find(params[:id])
    @medicine= Medicine.find_by(id: params[:medicine_id])
    if @purchase_order.add_medicine(@medicine) 
        flash[:notice] = t('purchase_order.addmed.success')  
        respond_to do |format|
          format.js{ render 'purchase_order/update_price' }
        end            
    else   
      flash[:error] = t('purchase_order.addmed.failure')   
      render :edit   
    end 
  end

  def show
    @purchase_order = PurchaseOrder.find(params[:id])
  end

  def edit
    @purchase_order = PurchaseOrder.find(params[:id])
  end

  def create
    @purchase_order = PurchaseOrder.new(purchase_order_params)
    #todo: fix this when PR is merged
    @purchase_order.hospital=Hospital.first 
    @purchase_order.admin=User.first  
    if @purchase_order.save!  
      flash[:notice] = t('purchase_order.create.success')   
      redirect_to @purchase_order
    else   
      flash[:error] = t('purchase_order.create.failure')    
      render :new  
    end
  end

  def update
    @purchase_order= PurchaseOrder.find(params[:id])  
    if @purchase_order.update_attributes(purchase_order_params)  
      flash[:notice] = t('purchase_order.update.success')    
      redirect_to @purchase_order         
    else   
      flash[:error] = t('purchase_order.update.failure')    
      render :edit   
    end   
  end

  def destroy
    @purchase_order = PurchaseOrder.find(params[:id])   
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
