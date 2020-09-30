require 'rails_helper'

RSpec.describe Bill, type: :model do
  context 'validations' do
    before(:each) do
      @hospital = Hospital.create(FactoryGirl.attributes_for(:hospital))
      @patient = Patient.create(FactoryGirl.attributes_for(:patient))
      @bill_params = FactoryGirl.attributes_for(:bills)
      @bill_params[:hospital] = @hospital
      @bill_params[:patient] = @patient
      @bill = @hospital.bills.create(@bill_params)
    end

    it 'should return true when validations pass' do
      expect(@bill.save).to eq true # fails validation
    end

    it 'should return false when validations fail' do
      @bill.patient=nil
      expect(@bill.save).to eq false
    end
  end

  context 'methods' do
    before(:each) do
      @hospital = Hospital.create(FactoryGirl.attributes_for(:hospital))
      @patient = Patient.create(FactoryGirl.attributes_for(:patient))
      @medicine_params = FactoryGirl.attributes_for(:medicine)
      @medicine_params[:hospital]=@hospital
      @medicine=@hospital.medicines.create(@medicine_params)
      @bill_params = FactoryGirl.attributes_for(:bills)
      @bill_params[:hospital] = @hospital
      @bill_params[:patient] = @patient
      @bill = @hospital.bills.create(@bill_params)
    end
  end
end