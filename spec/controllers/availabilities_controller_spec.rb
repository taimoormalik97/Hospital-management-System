require 'rails_helper'
RSpec.describe AvailabilitiesController, type: :controller do
  describe 'for doctor' do
    before(:each) do
      @hospital = Hospital.create(FactoryGirl.attributes_for(:hospital))
      params = FactoryGirl.attributes_for(:admin)
      params[:hospital] = @hospital
      admin = User.create(params)
      @doctor_params = FactoryGirl.attributes_for(:doctor)
      @doctor_params[:hospital] = @hospital
      @doctor = User.create(@doctor_params)
      @availability_params = FactoryGirl.attributes_for(:availability)
      @availability_params[:hospital] = @hospital
      @availability_params[:doctor] = @doctor
      @availability = Availability.create(@availability_params)
      binding.pry
      sign_in admin
      @availability_params[:week_day] = 'Tuesday'
      @request.host = "#{@hospital.sub_domain}.example.com/doctors/#{@doctor.sequence_num}"
    end
    
    ############# create #############
    describe 'POST create' do
      context 'with valid attributes' do
        it 'creates a new availability' do
          expect {
            post :create, params: { availability: @availability_params, doctor_id: @doctor.id }
          }.to change(@hospital.availabilities, :count).by(1)
        end

        it 'redirects to availabilities' do
          post :create, params: { availability: @availability_params, doctor_id: @doctor.id }
          expect(response).to redirect_to doctor_availabilities_path(@doctor.id)
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new availability' do
          @new_appointment_params[:date] = nil
          expect {
            post :create, params: { availability: @availability_params, doctor_id: @doctor.id }
          }.to_not change(@doctor.availabilities, :count)
        end

        it 're-renders the new method' do
          @availability_params[:date] = nil
          post :create, params: { availability: @availability_params }
          expect(response).to redirect_to doctor_availabilities_path(@doctor.id)
        end
      end
    end

    ############# index #############
    describe 'GET index' do
      it 'populates an array of availabilities' do
        get :index
        expect(assigns(:availabilities)).to eq([@availability])
      end

      it 'renders the :index view' do
        get :index
        expect(response).to render_template :index
      end
    end

    ############# destroy #############
    describe 'DELETE destroy' do
      it 'deletes the availability' do
        expect {
          delete :destroy, id: @availability
        }.to change(@doctor.availabilities, :count).by(-1)
      end

      it 'redirects to availabilities#index' do
        delete :destroy, id: @availability
        expect(response).to redirect_to doctor_availabilities_path(@doctor.id)
      end
    end

  end
end
