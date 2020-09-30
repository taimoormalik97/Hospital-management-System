require 'rails_helper'
require 'database_cleaner'
DatabaseCleaner.strategy = :truncation
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
    after(:each) do
      DatabaseCleaner.clean
    end
    # it 'has a 200 status code' do
    #   expect(response.status).to eq(200)
    # end

    # it 'should return http success when we call #index action' do
    #   expect(response).to have_http_status(:success)
    # end

    # it 'is expected to assign appointments instance variable' do
    #   expect(assigns[:appointments]).to eq @hospital.appointments
    # end
    ############# create #############
    describe 'POST create' do
      context 'with valid attributes' do
        it 'creates a new appointment' do
          expect {
            post :create, params: { appointment: @new_appointment_params }
          }.to change(Appointment.unscoped, :count).by(1)
        end

        it 'redirects to the new appointment' do
          post :create, params: { appointment: @new_appointment_params }
          response.should redirect_to appointments_path
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new appointment' do
          @new_appointment_params[:date] = nil
          expect {
            post :create, params: { appointment: @new_appointment_params }
          }.to_not change(Appointment.unscoped, :count)
        end

        it 're-renders the new method' do
          @new_appointment_params[:date] = nil
          post :create, params: { appointment: @new_appointment_params }
          response.should render_template :new
        end
      end
    end

    ############# new #############

    describe 'GET new' do
      it 'has a 200 status code' do
        get :new
        expect(response.status).to eq(200)
      end
    end

    ############# destroy #############
    describe 'DELETE destroy' do
      it 'deletes the medicine' do
        expect {
          delete :destroy, id: @medicine
        }.to change(Medicine.unscoped, :count).by(-1)
      end

      it 'redirects to medicines#index' do
        delete :destroy, id: @medicine
        response.should redirect_to medicines_url
      end
    end

    ############# index #############
    describe 'GET index' do
      it 'populates an array of medicines' do
        get :index
        assigns(:medicines).should eq([@medicine])
      end

      it 'renders the :index view' do
        get :index
        response.should render_template :index
      end
    end

    ############# show #############
    describe 'GET show' do
      it 'assigns the requested medicine to @medicine' do
        get :show, id: @medicine
        assigns(:medicine).should eq(@medicine)
      end

      it 'renders the #show view' do
        get :show, id: @medicine
        response.should render_template :show
      end
    end
  end
end
