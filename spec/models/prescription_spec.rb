require 'rails_helper'

RSpec.describe Prescription, type: :model do
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
    end

    it 'should return true when validations pass' do
      expect(@prescription.save).to eq true
    end

    it 'should return false when hospital doesn\'t exists' do
      @prescription.hospital = nil
      expect(@prescription.save).to eq false
    end

    it 'should return false when appointment doesn\'t exists' do
      @prescription.appointment = nil
      expect(@prescription.save).to eq false
    end
  end
end
