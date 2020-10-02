require 'rails_helper'
RSpec.describe DoctorsController, type: :controller do
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
      @doctor_params = FactoryGirl.attributes_for(:doctor)
      @doctor_params[:hospital] = @hospital
      @doctor = Doctor.create(@doctor_params)
      @new_doctor_params = FactoryGirl.attributes_for(:doctor)
      @new_doctor_params[:hospital] = @hospital
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

      it 'populates an array of doctors' do
        get :index
        expect(assigns(:doctors)).to eq([@doctor])
      end

      it 'renders the :index view' do
        get :index
        expect(response).to render_template :index
      end
    end

    ############# show #############
    describe 'GET show' do
      it 'renders the :show view' do
        get :show, params: { id: @doctor.sequence_num }
        expect(response).to render_template :show
      end
    end

    ############# edit #############
    describe 'GET edit' do
      it 'renders the :edit view' do
        get :edit, params: { id: @doctor.sequence_num }
        expect(response).to render_template :edit
      end
    end

    ############# create #############
    describe 'POST create' do
      context 'with valid attributes' do
        it 'creates a new doctor' do
          expect {
            post :create, params: { doctor: @new_doctor_params }
          }.to change(@hospital.doctors, :count).by(1)
        end

        it 'redirects to doctors index page' do
          post :create, params: { doctor: @new_doctor_params }
          expect(response).to redirect_to doctors_path
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new doctor' do
          @new_doctor_params[:name] = nil
          expect {
            post :create, params: { doctor: @new_doctor_params }
          }.to_not change(@hospital.doctors, :count)
        end

        it 're-renders the new method' do
          @new_doctor_params[:name] = nil
          post :create, params: { doctor: @new_doctor_params }
          expect(response).to render_template :new
        end
      end
    end

    ############# update #############
    describe 'PATCH update' do
      context 'with valid attributes' do
        it 'should return http success' do
          @doctor_params[:name] = 'New Name'
          expect {
            patch :update, params: { id: @doctor.sequence_num, doctor: @doctor_params}
          }.to_not change(@hospital.doctors, :count)
        end

        it 'redirects to doctor show page' do
          @doctor_params[:name] = 'New Name'
          patch :update, params: { id: @doctor.sequence_num, doctor: @doctor_params }
          expect(response).to redirect_to doctor_path(@hospital.doctors.first)
        end
      end

      context 'with invalid attributes' do
        it 'does not update the doctor' do
          @doctor_params[:name] = nil
          expect {
            patch :update, params: { id: @doctor.sequence_num, doctor: @doctor_params}
          }.to_not change(@hospital.doctors, :count)
        end

        it 're-renders the edit method' do
          @doctor_params[:name] = nil
          patch :update, params: { id: @doctor.sequence_num, doctor: @doctor_params }
          expect(response).to render_template :edit
        end
      end
    end

    ############# delete #############
    describe 'DELETE destroy' do
      it 'should return http success' do
        expect {
          delete :destroy, params: { id: @doctor.sequence_num }
        }.to change(@hospital.doctors, :count).by(-1)
      end

      it 'redirects to prescriptions index page' do
        delete :destroy, params: { id: @doctor.sequence_num }
        expect(response).to redirect_to doctors_path
      end
    end

  end
end
