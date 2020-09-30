require 'rails_helper'

RSpec.describe Bill, type: :model do
  context 'validations' do
    before(:each) do
      @hospital = Hospital.create(FactoryGirl.attributes_for(:hospital))
      @patient = Patient.create(FactoryGirl.attributes_for(:patient))
      @patient.id=2
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
      @patient.id=2
      @medicine_params = FactoryGirl.attributes_for(:medicine)
      @medicine_params[:hospital]=@hospital
      @medicine=@hospital.medicines.create(@medicine_params)
      @doctor_params = FactoryGirl.attributes_for(:doctor)
      @doctor_params[:hospital]=@hospital
      @doctor=@hospital.doctors.create(@doctor_params)
      @bill_params = FactoryGirl.attributes_for(:bills)
      @bill_params[:hospital] = @hospital
      @bill_params[:patient] = @patient
      @bill = @hospital.bills.create(@bill_params)
    end

    it 'should be able to add medicines to itself' do
      @bill.billable_type = 'medicine'
      @medicine.quantity = 10
      @quantity = 3
      expect(@bill.add_medicine(@medicine, @quantity)).to eq @hospital.bill_details.find_by(billable: @medicine)
    end

    it 'should be able to add doctors to itself' do
      @bill.billable_type = 'doctor'
      expect(@bill.add_doctor(@doctor)).to eq @hospital.bill_details.find_by(billable: @doctor)
    end

    it 'should decrement medicine quantity after adding to itself' do
      @medicine.quantity = 10
      previous_quantity = @medicine.quantity
      @quantity = 3
      @bill.add_medicine(@medicine, @quantity)
      expect(@medicine.quantity).to eq previous_quantity - @quantity 
    end

    it 'should increment its price after adding medicines to itself' do
      @medicine.quantity = 10
      @quantity = 3
      previous_price = @bill.price
      @bill.add_medicine(@medicine, @quantity)
      expect(@bill.price).to eq previous_price + @quantity*@medicine.price 
    end

    it 'should increment its price after adding doctors to itself' do
      previous_price = @bill.price
      @bill.add_doctor(@doctor)
      expect(@bill.price).to eq previous_price + @doctor.consultancy_fee
    end
  end
end