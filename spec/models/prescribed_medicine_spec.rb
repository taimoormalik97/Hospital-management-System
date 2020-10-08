require 'rails_helper'

RSpec.describe PrescribedMedicine, type: :model do
  context 'validations' do
    before(:each) do
      @hospital = Hospital.create(FactoryGirl.attributes_for(:hospital))
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
      @appointment_params = FactoryGirl.attributes_for(:appointment)
      @appointment_params[:hospital] = @hospital
      @appointment_params[:doctor] = @doctor
      @appointment_params[:patient] = @patient
      @appointment_params[:availability] = @availability
      @appointment = @hospital.appointments.create(@appointment_params)
      @prescription_params = FactoryGirl.attributes_for(:prescription)
      @prescription_params[:hospital] = @hospital
      @prescription_params[:appointment] = @appointment
      @prescription = Prescription.create(@prescription_params)
      @medicine_params = FactoryGirl.attributes_for(:medicine)
      @medicine_params[:hospital] = @hospital
      @medicine = Medicine.create(@medicine_params)
      @prescribed_medicine_params = FactoryGirl.attributes_for(:prescribed_medicine)
      @prescribed_medicine_params[:hospital] = @hospital
      @prescribed_medicine_params[:medicine] = @medicine
      @prescribed_medicine_params[:medicine_id] = @medicine.id
      @prescribed_medicine_params[:prescription] = @prescription
      @prescribed_medicine = PrescribedMedicine.create(@prescribed_medicine_params)
    end

    it 'should return true when validations pass' do
      expect(@prescribed_medicine.save).to eq true
    end

    it 'should return false when hospital doesn\'t exists' do
      @prescribed_medicine.hospital = nil
      expect(@prescribed_medicine.save).to eq false
    end

    it 'should return false when prescription doesn\'t exists' do
      @prescribed_medicine.prescription = nil
      expect(@prescribed_medicine.save).to eq false
    end

    it 'should return false when quantity of mentioned medicine doesn\'t exists' do
      @prescribed_medicine.quantity = nil
      expect(@prescribed_medicine.save).to eq false
    end

    it 'should return false when quantity is not a number' do
      @prescribed_medicine.quantity = 'abc'
      expect(@prescribed_medicine.save).to eq false
    end

    it 'should return false when usage_instruction of mentioned medicine doesn\'t exists' do
      @prescribed_medicine.usage_instruction = nil
      expect(@prescribed_medicine.save).to eq false
    end
  end
end
