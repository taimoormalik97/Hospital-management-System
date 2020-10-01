require 'rails_helper'

RSpec.describe Patient, type: :model do
  context 'validations' do
    before(:each) do
      @hospital = Hospital.create(FactoryGirl.attributes_for(:hospital))
      @patient_params = FactoryGirl.attributes_for(:patient)
      @patient_params[:hospital] = @hospital
      @patient = Patient.create(@patient_params)
    end

    it 'should return true when validations pass' do
      expect(@patient.save).to eq true
    end

    it 'should return false when validations fail' do
      @patient.hospital = nil
      expect(@patient.save).to eq false
    end

    it 'should return false when hospital doesn\'t exists' do
      @patient.hospital = nil
      expect(@patient.save).to eq false
    end

    it 'should return false when name is not present' do
      @patient.name = nil
      expect(@patient.save).to eq false
    end

    it 'should return false when length of name is less than 3' do
      @patient.name = 'ab'
      expect(@patient.save).to eq false
    end

    it 'should return false when format of email is incorrect' do
      @patient.email = 'InCorrectEmail'
      expect(@patient.save).to eq false
    end

    it 'should return false when format of email is incorrect' do
      @patient.email = 'InCorrectEmail.com'
      expect(@patient.save).to eq false
    end

    it 'should return true when format of email is correct' do
      @patient.email = 'CorrectEmail@gmail.com'
      expect(@patient.save).to eq true
    end

    context 'When testing the validation of unique email in same sub-domain' do
      before(:each) do
        @patient2 = Patient.create(@patient_params)
      end

      it 'should return false when same email is given in same sub-domain' do
        expect(@patient.save).to eq true
        expect(@patient2.save).to eq false
      end

      it 'should return true when different email is given in same sub-domain' do
        expect(@patient.save).to eq true
        @patient2.email = 'Email2@gmail.com'
        expect(@patient2.save).to eq true
      end
    end
  end
end
