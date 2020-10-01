require 'rails_helper'
RSpec.describe PrescriptionsController, type: :controller do
  describe 'for doctor' do
    before(:each) do
      @hospital = Hospital.create(FactoryGirl.attributes_for(:hospital))
      params = FactoryGirl.attributes_for(:admin)
      params[:hospital] = @hospital
      @admin = User.create(params)
      @doctor_params = FactoryGirl.attributes_for(:doctor)
      @doctor_params[:hospital] = @hospital
      @doctor = Doctor.create(@doctor_params)
      @request.env['devise.mapping'] = Devise.mappings[:doctor]
      @request.host = "#{@hospital.sub_domain}.localhost:3000"
      @doctor.confirm
      sign_in @doctor
      @availability_params = FactoryGirl.attributes_for(:availability)
      @availability_params[:hospital] = @hospital
      @availability_params[:doctor] = @doctor
      @availability = Availability.create(@availability_params)
      @patient_params = FactoryGirl.attributes_for(:patient)
      @patient_params[:hospital] = @hospital
      @patient = Patient.create(@patient_params)
      @appointment_params = FactoryGirl.attributes_for(:appointment)
      @appointment_params[:hospital] = @hospital
      @appointment_params[:doctor] = @doctor
      @appointment_params[:patient] = @patient
      @appointment_params[:availability] = @availability
      @appointment = @hospital.appointments.create(@appointment_params)
      @prescription_params = FactoryGirl.attributes_for(:prescription)
      @prescription_params[:hospital] = @hospital
      @prescription_params[:appointment] = @appointment
      @prescription = @hospital.prescriptions.create(@prescription_params)
    end

    after(:each) do
      sign_out @doctor
    end

    ############# index #############
    describe 'GET index' do
      it 'has a 200 status code' do
        expect(response.status).to eq(200)
      end

      it 'should return http success' do
        expect(response).to have_http_status(:success)
      end

      it 'populates an array of prescriptions' do
        get :index
        expect(assigns(:prescriptions)).to eq([@prescription])
      end

      it 'renders the :index view' do
        get :index
        expect(response).to render_template :index
      end
    end

    ############# edit #############
    describe 'GET edit' do
      it 'renders the :edit view' do
        get :edit, params: { id: @prescription.sequence_num }
        expect(response).to render_template :edit
      end
    end

    ############# update #############
    describe 'PATCH update' do
      it 'should return http success' do
        @prescription_params[:notes] = 'Notes Added' 
        expect {
          patch :update, params: { id: @prescription.sequence_num, prescription: @prescription_params}
        }.to_not change(@hospital.prescriptions, :count)
      end

      it 'redirects to prescription show page' do
        @prescription_params[:notes] = 'Notes Added'
        patch :update, params: { id: @prescription.sequence_num, prescription: @prescription_params }
        expect(response).to redirect_to prescription_path(@hospital.prescriptions.first)
      end
    end

    ############# delete #############
    describe 'DELETE destroy' do
      it 'should return http success' do
        expect {
          delete :destroy, params: { id: @prescription.sequence_num }
        }.to change(@hospital.prescriptions, :count).by(-1)
      end

      it 'redirects to prescriptions index page' do
        delete :destroy, params: { id: @prescription.sequence_num }
        expect(response).to redirect_to prescriptions_path
      end
    end
  end
end
