require 'rails_helper'

RSpec.describe AppointmentsController, type: :controller do
  describe 'for admin' do
    context '#index action' do
      before(:each) do
        @current_hospital = Hospital.create(FactoryGirl.attributes_for(:hospital))
        params = FactoryGirl.attributes_for(:admin)
        params[:hospital] = @current_hospital
        # @request.env['devise.mapping'] = Devise.mappings[:admin]
        admin = Admin.create(params)
        admin.confirm
        sign_in(admin)
        @doctor_params = FactoryGirl.attributes_for(:doctor)
        @doctor_params[:hospital] = @current_hospital
        @doctor = Doctor.create(@doctor_params)
        @availability_params = FactoryGirl.attributes_for(:availability)
        @availability_params[:hospital] = @current_hospital
        @availability_params[:doctor] = @doctor
        @availability = Availability.create(@availability_params)
        @patient_params = FactoryGirl.attributes_for(:patient)
        @patient_params[:hospital] = @current_hospital
        @patient = Patient.create(@patient_params)
        @appointment_params = FactoryGirl.attributes_for(:appointment)
        @appointment_params[:hospital] = @current_hospital
        @appointment_params[:doctor] = @doctor
        @appointment_params[:patient] = @patient
        @appointment_params[:availability] = @availability
        @appointment = @current_hospital.appointments.create(@appointment_params)
        @request.host = 'test.example.com'
        #get :index
      end

      it 'has a 200 status code' do
        get :new
        expect(response.status).to eq(200)
      end

      it 'should return http success when we call #index action' do
        expect(response).to have_http_status(:success)
      end

      it 'is expected to assign appointments instance variable' do
        expect(assigns[:appointments]).to eq @current_hospital.appointments
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
        @appointment = @current_hospital.appointments.create(FactoryGirl.attributes_for(:appointment))

        get :new
      end

      it 'should return http success' do
        expect(response).to have_http_status(:success)
      end

      it 'is expected to assign appointment instance variable' do
        expect(assigns(:appointment).id).to eq @current_hospital.appointments.new.id
      end
    end

    context '#create action' do
      before(:each) do
        @current_hospital = Hospital.create(FactoryGirl.attributes_for(:hospital))
        params = FactoryGirl.attributes_for(:admin)
        params[:hospital_id] = @current_hospital.id
        @request.env['devise.mapping'] = Devise.mappings[:admin]
        @request.host = "#{@current_hospital.sub_domain}.localhost:3000"
        admin = Admin.create(params)
        admin.confirm
        sign_in(admin)
        @appointment = @current_hospital.appointments.create(FactoryGirl.attributes_for(:appointment))

        post :create, appointment: FactoryGirl.attributes_for(:appointment)
      end

      it 'should return http success' do
        expect(response).to redirect_to "/appointments/#{@appointment.sequence_num + 1}"
      end
    end
  end
end
