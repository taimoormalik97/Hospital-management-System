require 'rails_helper'
RSpec.describe AvailabilitiesController, type: :controller do
  describe 'for doctor' do
    before(:each) do
      @hospital = Hospital.create(FactoryGirl.attributes_for(:hospital))
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
      @new_availability_params = FactoryGirl.attributes_for(:availability)
      @new_availability_params[:start_slot] = DateTime.current.beginning_of_hour() + 1.hour
      @new_availability_params[:end_slot] = DateTime.current.beginning_of_hour() + 1.hour + 30.minutes
      @new_availability_params[:hospital] = @hospital
      @new_availability_params[:doctor] = @doctor
    end
    
    ############# create #############
    describe 'POST create' do
      context 'with valid attributes' do
        it 'creates a new availability' do
          expect {
            post :create, params: { doctor_id: @doctor.sequence_num, availability: @new_availability_params }
          }.to change(@hospital.availabilities, :count).by(1)
        end

        it 'redirects to availabilities' do
          post :create, params: { availability: @availability_params, doctor_id: @doctor.sequence_num }
          expect(response).to redirect_to doctor_availabilities_path(@doctor.sequence_num, week_day: @new_availability_params[:week_day])
        end
      end

      context 'with invalid attributes' do
        it 'does not save the new availability' do
          @new_availability_params[:doctor] = nil
          expect {
            post :create, params: { doctor_id: @doctor.sequence_num, availability: @new_availability_params }
          }.to_not change(@doctor.availabilities, :count)
        end

        it 'redirects to availabilities#index' do
          @new_availability_params[:doctor] = nil
          post :create, params: { doctor_id: @doctor.sequence_num, availability: @new_availability_params }
          expect(response).to redirect_to doctor_availabilities_path(@doctor.sequence_num, week_day: @new_availability_params[:week_day])
        end
      end
    end

    ############# index #############
    describe 'GET index' do
      it 'populates an array of availabilities' do
        get :index, params: { doctor_id: @doctor.sequence_num }
        expect(@hospital.availabilities).to eq([@availability])
      end

      it 'renders the :index view' do
        get :index, params: { doctor_id: @doctor.sequence_num }
        expect(response).to render_template :index
      end
    end

    ############# destroy #############
    describe 'DELETE destroy' do
      it 'deletes the availability' do
        expect {
          delete :destroy, params: { doctor_id: @doctor.sequence_num, id: @availability }
        }.to change(@hospital.availabilities, :count).by(-1)
      end

      it 'redirects to availabilities#index' do
        delete :destroy, params: { doctor_id: @doctor.sequence_num, id: @availability }
        expect(response).to redirect_to doctor_availabilities_path(@doctor.sequence_num, week_day: @availability_params[:week_day])
      end
    end

  end
end
