require 'rails_helper'

RSpec.describe PurchaseOrderController, type: :controller do
  describe 'for admin' do
    context '#index action' do
      before(:each) do
       @current_hospital = Hospital.create(FactoryGirl.attributes_for(:hospital))
        params = FactoryGirl.attributes_for(:admin)
        params[:hospital_id] = @current_hospital.id
        @request.env['devise.mapping'] = Devise.mappings[:admin]
        @request.host = "#{@current_hospital.sub_domain}.localhost:3000"
        admin = Admin.create(params)
        admin.confirm
        sign_in(admin)
      end

      it 'should return http success when we call #index action' do
        get :index
        expect(response).to have_http_status(:success)
      end
    end

    context '#new action' do
      before(:each) do
        @current_hospital = Hospital.create(FactoryGirl.attributes_for(:hospital))
        params = FactoryGirl.attributes_for(:admin)
        params[:hospital_id] = @current_hospital.id
        @request.env['devise.mapping'] = Devise.mappings[:admin]
        @request.host = "#{@current_hospital.sub_domain}.localhost:3000"
        admin = Admin.create(params)
        admin.confirm
        sign_in(admin)
        get :new
      end

      it 'has a 200 status code' do
        expect(response.status).to eq(200)
      end

      it 'should return http success' do
        expect(response).to have_http_status(:success)
      end
    end

    context '#create action' do
      before(:each) do
        @current_hospital = Hospital.create(FactoryGirl.attributes_for(:hospital))
        Hospital.current_id=@current_hospital.id
        params = FactoryGirl.attributes_for(:admin)
        params[:hospital_id] = @current_hospital.id
        @request.env['devise.mapping'] = Devise.mappings[:admin]
        @request.host = "#{@current_hospital.sub_domain}.localhost:3000"
        admin = Admin.create(params)
        admin.confirm
        sign_in(admin)
        @purchase_order = FactoryGirl.attributes_for(:purchase_orders)        
      end

      it 'should return http success' do
        post :create, params: { purchase_order: @purchase_order }
        expect(response).to redirect_to purchase_order_path(@current_hospital.purchase_orders.first)
      end
    end

    context '#update action' do
      before(:each) do
        @current_hospital = Hospital.create(FactoryGirl.attributes_for(:hospital))
        Hospital.current_id=@current_hospital.id
        params = FactoryGirl.attributes_for(:admin)
        params[:hospital_id] = @current_hospital.id
        @request.env['devise.mapping'] = Devise.mappings[:admin]
        @request.host = "#{@current_hospital.sub_domain}.localhost:3000"
        admin = Admin.create(params)
        admin.confirm
        sign_in(admin)
        @purchase_order_params = FactoryGirl.attributes_for(:purchase_orders)
        @purchase_order_params[:admin] = admin 
        @purchase_order = @current_hospital.purchase_orders.create(@purchase_order_params)     
      end

      it 'should return http success' do
        purchase_order_params = { vendorname: 'xyz'}
        put :update, params: { id: @purchase_order.sequence_num, purchase_order: purchase_order_params}
        expect(response).to redirect_to purchase_order_path(@current_hospital.purchase_orders.first)
      end
    end

    context '#delete action' do
      before(:each) do
        @current_hospital = Hospital.create(FactoryGirl.attributes_for(:hospital))
        Hospital.current_id=@current_hospital.id
        params = FactoryGirl.attributes_for(:admin)
        params[:hospital_id] = @current_hospital.id
        @request.env['devise.mapping'] = Devise.mappings[:admin]
        @request.host = "#{@current_hospital.sub_domain}.localhost:3000"
        admin = Admin.create(params)
        admin.confirm
        sign_in(admin)
        @purchase_order_params = FactoryGirl.attributes_for(:purchase_orders)
        @purchase_order_params[:admin] = admin 
        @purchase_order = @current_hospital.purchase_orders.create(@purchase_order_params)        
      end

      it 'should return http success' do
        delete :destroy, params: { id: @purchase_order.sequence_num }
        expect(response).to redirect_to purchase_order_index_path
      end
    end
  end
end