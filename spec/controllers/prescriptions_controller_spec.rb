require 'rails_helper'
RSpec.describe PrescriptionsController, type: :controller do
  describe 'for doctor' do
    before(:each) do
      @hospital = Hospital.create(FactoryGirl.attributes_for(:hospital))
      params = FactoryGirl.attributes_for(:admin)
      params[:hospital] = @hospital
      @request.host = "#{@hospital.sub_domain}.example.com"
      @admin = User.create(params)
      @doctor_params = FactoryGirl.attributes_for(:doctor)
      @doctor_params[:hospital] = @hospital
      @doctor = Doctor.create(@doctor_params)
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
      @new_prescription_params = { hospital_id: @hospital.id, appointment_id: @appointment.id }
    end

    after(:each) do
      sign_out @doctor
    end

    ############# index #############
    describe 'GET index' do
      it 'populates an array of prescriptions' do
        get :index
        expect(response).to have_http_status(:success)
        expect(assigns(:prescriptions)).to eq([@prescription])
      end

      it 'renders the :index view' do
        get :index
        expect(response).to render_template :index
      end
    end
  end
end
