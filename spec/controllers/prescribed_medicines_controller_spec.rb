require 'rails_helper'
RSpec.describe PrescribedMedicinesController, type: :controller do
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
      @medicine_params = FactoryGirl.attributes_for(:medicine)
      @medicine_params[:hospital] = @hospital
      @medicine = Medicine.create(@medicine_params)
      @prescribed_medicine_params = FactoryGirl.attributes_for(:prescribed_medicine)
      @prescribed_medicine_params[:hospital] = @hospital
      @prescribed_medicine_params[:medicine] = @medicine
      @prescribed_medicine_params[:prescription] = @prescription
      @prescribed_medicine_params[:medicine_id] = @medicine.id
      @prescribed_medicine = @hospital.prescribed_medicines.create(@prescribed_medicine_params)
      @new_prescribed_medicine_params = FactoryGirl.attributes_for(:prescribed_medicine)
      @new_prescribed_medicine_params[:hospital] = @hospital
      @new_prescribed_medicine_params[:medicine] = @medicine
      @new_prescribed_medicine_params[:prescription] = @prescription
      @new_prescribed_medicine_params[:medicine_id] = @medicine.id
    end

    after(:each) do
      sign_out @doctor
    end
    
    ############# create #############
    describe 'POST create' do
      context 'with valid attributes' do
        it 'creates a new medicine in prescription' do
          expect {
            post :create, params: { prescription_id: @prescription.sequence_num, prescribed_medicine: @new_prescribed_medicine_params, medicine_id: @medicine.sequence_num, format: :js }
          }.to change(@hospital.prescribed_medicines, :count).by(1)
        end

        it 'redirects to prescription show page' do
          post :create, params: { prescription_id: @prescription.sequence_num, prescribed_medicine: @new_prescribed_medicine_params, medicine_id: @medicine.sequence_num, format: :js }
          expect(response).to render_template('prescriptions/medicines_in_prescription')
        end
      end
    end

    ############# delete #############
    describe 'DELETE destroy' do
      it 'deletes a medicine from prescription' do
        expect {
            delete :destroy, params: { prescription_id: @prescription.sequence_num, id: @prescribed_medicine.sequence_num, medicine_id: @medicine.sequence_num, format: :js }
          }.to change(@hospital.prescribed_medicines, :count).by(-1)
      end

      it 'redirects to prescription show page' do
        delete :destroy, params: { prescription_id: @prescription.sequence_num, id: @prescribed_medicine.sequence_num, medicine_id: @medicine.sequence_num, format: :js }
        expect(response).to render_template('prescriptions/medicines_in_prescription')
      end
    end
  end
end
