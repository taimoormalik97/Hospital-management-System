require 'rails_helper'

RSpec.describe Doctor, type: :model do
  context 'validations' do
    before(:each) do
      @hospital = Hospital.create(FactoryGirl.attributes_for(:hospital))
      @doctor_params = FactoryGirl.attributes_for(:doctor)
      @doctor_params[:hospital] = @hospital
      @doctor = Doctor.create(@doctor_params)
    end

    it 'should return true when all validations pass' do
      expect(@doctor.save).to eq true
    end

    it 'should return false when hospital doesn\'t exists' do
      @doctor.hospital = nil
      expect(@doctor.save).to eq false
    end

    it 'should return false when name is not present' do
      @doctor.name = nil
      expect(@doctor.save).to eq false
    end

    it 'should return false when length of name is less than 3' do
      @doctor.name = 'ab'
      expect(@doctor.save).to eq false
    end

    it 'should return false when format of email is incorrect' do
      @doctor.email = 'InCorrectEmail'
      expect(@doctor.save).to eq false
    end

    it 'should return false when format of email is incorrect' do
      @doctor.email = 'InCorrectEmail.com'
      expect(@doctor.save).to eq false
    end

    it 'should return true when format of email is correct' do
      @doctor.email = 'CorrectEmail@gmail.com'
      expect(@doctor.save).to eq true
    end

    it 'should return false when consultancy_fee is not a number' do
      @doctor.consultancy_fee = 'abc'
      expect(@doctor.save).to eq false
    end

    it 'should return false when registration_no is not a number' do
      @doctor.registration_no = "abc"
      expect(@doctor.save).to eq false
    end

    context 'When testing the validation of unique email and registration_no in same sub-domain' do
      before(:each) do
        @doctor2 = Doctor.create(@doctor_params)
      end

      it 'should return false when same email and registration_no is given in same sub-domain' do
        expect(@doctor.save).to eq true
        expect(@doctor2.save).to eq false
      end

      it 'should return true when different email and registration_no is given in same sub-domain' do
        expect(@doctor.save).to eq true
        @doctor2.email = 'OtherEmail@gmail.com'
        @doctor2.registration_no = 12345
        expect(@doctor2.save).to eq true
      end
    end
  end
end
