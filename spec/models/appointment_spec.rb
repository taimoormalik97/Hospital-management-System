require 'rails_helper'

RSpec.describe Appointment, type: :model do
  context 'validations' do
    before(:all) do
      binding.pry
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
    end

    it 'should return true when validations pass' do
      expect(@appointment.save).to eq true # fails validation
    end

    it 'should return false when validations fail' do
      @appointment.date = nil
      expect(@appointment.save).to eq false
    end
  end

  context 'methods' do
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
    end

    it 'should return true if status is pending when we call pending? method' do
      expect(@appointment.pending?).to eq true
    end

    it 'should return false if status is not pending when we call pending? method' do
      @appointment.approve!
      expect(@appointment.pending?).to eq false
    end

    it 'should return true if status is canceled when we call canceled? method' do
      @appointment.cancel!
      expect(@appointment.canceled?).to eq true
    end

    it 'should return false if status is not canceled when we call canceled? method' do
      expect(@appointment.canceled?).to eq false
    end

    it 'should return true if status is approved when we call approved? method' do
      @appointment.approve!
      expect(@appointment.approved?).to eq true
    end

    it 'should return false if status is not approved when we call approved? method' do
      expect(@appointment.approved?).to eq false
    end

    it 'should return true if status is completed when we call completed? method' do
      @appointment.approve!
      @appointment.complete!
      expect(@appointment.completed?).to eq true
    end

    it 'should return false if status is not completed when we call completed? method' do
      expect(@appointment.completed?).to eq false
    end

    it 'should change the status to Canceled when we call cancel! method' do
      expect(@appointment.cancel!).to eq true
    end
  end
end
