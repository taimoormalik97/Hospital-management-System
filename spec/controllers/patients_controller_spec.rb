require 'rails_helper'
RSpec.describe PatientsController, type: :controller do
  describe 'for admin' do
    before(:each) do
      @hospital = Hospital.create(FactoryGirl.attributes_for(:hospital))
      @admin_params = FactoryGirl.attributes_for(:admin)
      @admin_params[:hospital] = @hospital
      @admin = User.create(@admin_params)
      @request.env['devise.mapping'] = Devise.mappings[:admin]
      @request.host = "#{@hospital.sub_domain}.localhost:3000"
      @admin.confirm
      sign_in @admin
      @patient_params = FactoryGirl.attributes_for(:patient)
      @patient_params[:hospital] = @hospital
      @patient = Patient.create(@patient_params)
      @new_patient_params = FactoryGirl.attributes_for(:patient)
      @new_patient_params[:hospital] = @hospital
    end

    after(:each) do
      sign_out @admin
    end

    ############# index #############
    describe 'GET index' do
      it 'has a 200 status code' do
        expect(response.status).to eq(200)
      end

      it 'should return http success' do
        expect(response).to have_http_status(:success)
      end

      it 'populates an array of patients' do
        get :index
        expect(assigns(:patients)).to eq([@patient])
      end

      it 'renders the :index view' do
        get :index
        expect(response).to render_template :index
      end
    end

    ############# show #############
    describe 'GET show' do
      it 'renders the :show view' do
        get :show, params: { id: @patient.sequence_num }
        expect(response).to render_template :show
      end
    end

    ############# edit #############
    describe 'GET edit' do
      it 'renders the :edit view' do
        get :edit, params: { id: @patient.sequence_num }
        expect(response).to render_template :edit
      end
    end

    ############# create #############
    describe 'POST create' do
      context 'with valid attributes' do
        it 'creates a new patient' do
          expect {
            post :create, params: { patient: @new_patient_params }
          }.to change(@hospital.patients, :count).by(1)
        end

        it 'redirects to patients index page' do
          post :create, params: { patient: @new_patient_params }
          expect(response).to redirect_to patients_path
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new patient' do
          @new_patient_params[:name] = nil
          expect {
            post :create, params: { patient: @new_patient_params }
          }.to_not change(@hospital.patients, :count)
        end

        it 're-renders the new method' do
          @new_patient_params[:name] = nil
          post :create, params: { patient: @new_patient_params }
          expect(response).to render_template :new
        end
      end
    end

    ############# update #############
    describe 'PATCH update' do
      context 'with valid attributes' do
        it 'should return http success' do
          @patient_params[:name] = 'New Name'
          expect {
            patch :update, params: { id: @patient.sequence_num, patient: @patient_params}
          }.to_not change(@hospital.patients, :count)
        end

        it 'redirects to patient show page' do
          @patient_params[:name] = 'New Name'
          patch :update, params: { id: @patient.sequence_num, patient: @patient_params }
          expect(response).to redirect_to patient_path(@hospital.patients.first)
        end
      end

      context 'with invalid attributes' do
        it 'does not update the patient' do
          @patient_params[:name] = nil
          expect {
            patch :update, params: { id: @patient.sequence_num, patient: @patient_params}
          }.to_not change(@hospital.patients, :count)
        end

        it 're-renders the edit method' do
          @patient_params[:name] = nil
          patch :update, params: { id: @patient.sequence_num, patient: @patient_params }
          expect(response).to render_template :edit
        end
      end
    end

    ############# delete #############
    describe 'DELETE destroy' do
      it 'should return http success' do
        expect {
          delete :destroy, params: { id: @patient.sequence_num }
        }.to change(@hospital.patients, :count).by(-1)
      end

      it 'redirects to prescriptions index page' do
        delete :destroy, params: { id: @patient.sequence_num }
        expect(response).to redirect_to patients_path
      end
    end

  end
end
