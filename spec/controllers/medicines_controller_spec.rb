require 'rails_helper'

RSpec.describe MedicinesController, type: :controller do
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
        @medicine = FactoryGirl.attributes_for(:medicine)        
      end

      it 'should return http success' do
        post :create, params: { medicine: @medicine }
        expect(response).to redirect_to medicine_path(@current_hospital.medicines.first)
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
        @medicine = FactoryGirl.attributes_for(:medicine)
        @medicine = @current_hospital.medicines.create(@medicine)       
      end

      it 'should return http success' do
        medicine_params = { name: 'med22'}
        put :update, params: { id: @medicine.sequence_num, medicine: medicine_params}
        expect(response).to redirect_to medicine_path(@current_hospital.medicines.first)
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
        @medicine = FactoryGirl.attributes_for(:medicine)
        @medicine = @current_hospital.medicines.create(@medicine)        
      end

      it 'should return http success' do
        delete :destroy, params: { id: @medicine.sequence_num }
        expect(response).to redirect_to medicines_path
      end
    end
  end
end