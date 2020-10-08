require 'rails_helper'

RSpec.describe Admin, type: :model do
  context 'validations' do
    before(:each) do
      @hospital = Hospital.create(FactoryGirl.attributes_for(:hospital))
      @admin_params = FactoryGirl.attributes_for(:admin)
      @admin_params[:hospital] = @hospital
      @admin = Admin.create(@admin_params)
    end

    it 'should return true when all validations pass' do
      expect(@admin.save).to eq true
    end

    it 'should return false when hospital doesn\'t exists' do
      @admin.hospital = nil
      expect(@admin.save).to eq false
    end

    it 'should return false when name is not present' do
      @admin.name = nil
      expect(@admin.save).to eq false
    end

    it 'should return false when length of name is less than 3' do
      @admin.name = 'ab'
      expect(@admin.save).to eq false
    end

    it 'should return false when format of email is incorrect' do
      @admin.email = 'InCorrectEmail'
      expect(@admin.save).to eq false
    end

    it 'should return false when format of email is incorrect' do
      @admin.email = 'InCorrectEmail.com'
      expect(@admin.save).to eq false
    end

    it 'should return true when format of email is correct' do
      @admin.email = 'CorrectEmail@gmail.com'
      expect(@admin.save).to eq true
    end

    context 'When testing the validation of unique email in same sub-domain' do
      before(:each) do
        @doctor_params = FactoryGirl.attributes_for(:doctor)
        @doctor_params[:hospital] = @hospital
        @doctor = Doctor.create(@doctor_params)
      end

      it 'should return false when same email is given in same sub-domain' do
        @doctor.email = @admin.email
        expect(@admin.save).to eq true
        expect(@doctor.save).to eq false
      end

      it 'should return true when different email is given in same sub-domain' do
        expect(@admin.save).to eq true
        @doctor.email = 'NewEmail@gmail.com'
        expect(@doctor.save).to eq true
      end
    end
  end
end
