require 'rails_helper'

RSpec.describe Availability, type: :model do
  context 'validations' do
    before(:all) do
      @hospital = Hospital.create(FactoryGirl.attributes_for(:hospital))
      @doctor_params = FactoryGirl.attributes_for(:doctor)
      @doctor_params[:hospital] = @hospital
      @doctor = Doctor.create(@doctor_params)
      @availability_params = FactoryGirl.attributes_for(:availability)
      @availability_params[:hospital] = @hospital
      @availability_params[:doctor] = @doctor
      @availability = Availability.create(@availability_params)
    end

    it 'should return true when validations pass' do
      expect(@availability.save).to eq true # fails validation
    end

    it 'should return false when validations fail' do
      @availability.end_slot = nil
      expect(@availability.save).to eq false
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
    end

  end
end
