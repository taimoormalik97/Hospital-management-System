require 'rails_helper'

RSpec.describe BillsController, type: :controller do
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
        @patient = @current_hospital.patients.create(FactoryGirl.attributes_for(:patient))
        @bill = FactoryGirl.attributes_for(:bills) 
        @bill[:patient] = @current_hospital.patients.first
        @bill[:patient_id] = @current_hospital.patients.first.id    
      end

      it 'should return http success' do
        post :create, params: { bill: @bill }
        expect(response).to redirect_to bill_path(@current_hospital.bills.first)
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
        @patient = @current_hospital.patients.create(FactoryGirl.attributes_for(:patient))
        @bill_params = FactoryGirl.attributes_for(:bills)
        @bill_params[:patient] = @current_hospital.patients.first
        @bill_params[:patient_id] = @current_hospital.patients.first.id  
        @bill = @current_hospital.bills.create(@bill_params)     
      end

      it 'should return http success' do
        bill_params = { price: 10}
        put :update, params: { id: @bill.sequence_num, bill: @bill_params}
        expect(response).to redirect_to bill_path(@current_hospital.bills.first)
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
        @patient = @current_hospital.patients.create(FactoryGirl.attributes_for(:patient))
        @bill_params = FactoryGirl.attributes_for(:bills)
        @bill_params[:patient] = @current_hospital.patients.first
        @bill_params[:patient_id] = @current_hospital.patients.first.id  
        @bill = @current_hospital.bills.create(@bill_params)          
      end

      it 'should return http success' do
        delete :destroy, params: { id: @bill.sequence_num }
        expect(response).to redirect_to bills_path
      end
    end
  end
end