class PurchaseOrderController < ApplicationController
  def index
    @purchase_orders = PurchaseOrder.all    
  end

  def new
    @purchase_order = PurchaseOrder.new
  end

  def show
    @purchase_order = PurchaseOrder.find(params[:id])
  end
  def edit
    @purchase_order = PurchaseOrder.find(params[:id])
  end
  def create
    @purchase_order = PurchaseOrder.new(purchase_order_params)
    @purchase_order.hospital=Hospital.first 
    @purchase_order.admin=User.first  
    if @purchase_order.save!  
        flash[:notice] = 'Order successfully added!'   
        redirect_to purchase_order_index_path  
    else   
        flash[:error] = 'Failed to add order'   
        render :new  
    end
  end


  def update
    @purchase_order= PurchaseOrder.find(params[:id])   
    if @purchase_order.update_attributes(purchase_order_params)   
        flash[:notice] = 'Order updated!'   
        redirect_to purchase_order_index_path          
    else   
        flash[:error] = 'Failed!'   
        render :edit   
    end   
  end

  def destroy
    @purchase_order = PurchaseOrder.find(params[:id])   
    if @purchase_order.delete 
        flash[:notice] = 'Order deleted!'   
        redirect_to purchase_order_index_path    
    else   
        flash[:error] = 'Failed to delete!'   
        render :destroy 
    end
  end
  def purchase_order_params   
    params.require(:purchase_order).permit(:vendorname, :price, :state)   
  end  
end
