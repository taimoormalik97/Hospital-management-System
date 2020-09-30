require 'rails_helper'
RSpec.describe AppointmentsController, type: :controller do
  describe 'for patient' do
    before(:each) do
      @hospital = Hospital.create(FactoryGirl.attributes_for(:hospital))
      params = FactoryGirl.attributes_for(:admin)
      params[:hospital] = @hospital
      @request.host = "#{@hospital.sub_domain}.example.com"
      admin = User.create(params)
      @doctor_params = FactoryGirl.attributes_for(:doctor)
      @doctor_params[:hospital] = @hospital
      @doctor = Doctor.create(@doctor_params)
      @availability_params = FactoryGirl.attributes_for(:availability)
      @availability_params[:hospital] = @hospital
      @availability_params[:doctor] = @doctor
      @availability = Availability.create(@availability_params)
      @patient_params = FactoryGirl.attributes_for(:patient)
      @patient_params[:hospital] = @hospital
      @patient = Patient.create(@patient_params)
      sign_in @patient
      @appointment_params = FactoryGirl.attributes_for(:appointment)
      @appointment_params[:hospital] = @hospital
      @appointment_params[:doctor] = @doctor
      @appointment_params[:patient] = @patient
      @appointment_params[:availability] = @availability
      @appointment = @hospital.appointments.create(@appointment_params)
      @availability_params[:week_day] = 'Tuesday'
      @new_availability = Availability.create(@availability_params)
      @new_appointment_params = { date: DateTime.current+1, state: 'pending', hospital_id: @hospital.id, doctor_id: @doctor.id, patient_id: @patient.id , availability_id: @availability.id }
    end
    
    ############# create #############
    describe 'POST create' do
      context 'with valid attributes' do
        it 'creates a new appointment' do
          expect {
            post :create, params: { appointment: @new_appointment_params }
          }.to change(@hospital.appointments, :count).by(1)
        end

        it 'redirects to appointments' do
          post :create, params: { appointment: @new_appointment_params }
          expect(response).to redirect_to appointments_path
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new appointment' do
          @new_appointment_params[:date] = nil
          expect {
            post :create, params: { appointment: @new_appointment_params }
          }.to_not change(@hospital.appointments, :count)
        end

        it 're-renders the new method' do
          @new_appointment_params[:date] = nil
          post :create, params: { appointment: @new_appointment_params }
          expect(response).to redirect_to appointments_path
        end
      end
    end

    ############# index #############
    describe 'GET index' do
      it 'populates an array of appointments' do
        get :index
        expect(assigns(:appointments)).to eq([@appointment])
      end

      it 'renders the :index view' do
        get :index
        expect(response).to render_template :index
      end
    end
  end
end
