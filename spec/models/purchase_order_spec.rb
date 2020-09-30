require 'rails_helper'

RSpec.describe PurchaseOrder, type: :model do
  context 'validations' do
  	before(:each) do
  		@hospital = Hospital.create(FactoryGirl.attributes_for(:hospital))
      @admin = Admin.create(FactoryGirl.attributes_for(:admin))
  		@purchase_order_params = FactoryGirl.attributes_for(:purchase_orders)
  		@purchase_order_params[:hospital] = @hospital
      @purchase_order_params[:admin] = @admin
  		@purchase_order = @hospital.purchase_orders.create(@purchase_order_params)
  	end

  	it 'should return true when validations pass' do
      expect(@purchase_order.save).to eq true # fails validation
    end

    it 'should return false when validations fail' do
      @purchase_order.price = -10
      expect(@purchase_order.save).to eq false
    end
  end
  context 'methods' do
  	before(:each) do
  		@hospital = Hospital.create(FactoryGirl.attributes_for(:hospital))
  		@medicine_params = FactoryGirl.attributes_for(:medicine)
  		@medicine_params[:hospital]=@hospital
  		@medicine=@hospital.medicines.create(@medicine_params)
      @admin = Admin.create(FactoryGirl.attributes_for(:admin))
      @purchase_order_params = FactoryGirl.attributes_for(:purchase_orders)
      @purchase_order_params[:hospital] = @hospital
      @purchase_order_params[:admin] = @admin
      @purchase_order = @hospital.purchase_orders.create(@purchase_order_params)
  	end
   
    it 'should be able to add medicines to itself' do
       @medicine.quantity = 10
       @quantity = 3
       expect(@purchase_order.add_medicine(@medicine, @quantity)).to eq @hospital.purchase_details.find_by(medicine_id: @medicine.id)
    end

    it 'should decrement medicine quantity after adding to itself' do
       @medicine.quantity = 10
       previous_quantity = @medicine.quantity
       @quantity = 3
       @purchase_order.add_medicine(@medicine, @quantity)
       expect(@medicine.quantity).to eq previous_quantity - @quantity 
    end

    it 'should increment its price after adding medicines to itself' do
       @medicine.quantity = 10
       @quantity = 3
       previous_price = @purchase_order.price
       @purchase_order.add_medicine(@medicine, @quantity)
       expect(@purchase_order.price).to eq previous_price + @quantity*@medicine.price 
    end

    it 'should return true if order is drafted when we call drafted? method' do
      expect(@purchase_order.drafted?).to eq true
    end
    #changes to be made after merging. call .confirm! and .deliver! instead of confirmed! and delivered!
    it 'should return false if order is not drafted when we call drafted? method' do
      @purchase_order.confirmed!
      expect(@purchase_order.drafted?).to eq false
    end

    it 'should return true if order is confirmed when we call confirmed? method' do
      @purchase_order.confirmed!
      expect(@purchase_order.confirmed?).to eq true
    end

    it 'should return false if order is not confirmed when we call confirmed? method' do
      expect(@purchase_order.confirmed?).to eq false
    end

    it 'should return true if order is delivered when we call delivered? method' do
      @purchase_order.confirmed!
      @purchase_order.delivered!
      expect(@purchase_order.delivered?).to eq true
    end

    it 'should return false if order is not delivered when we call delivered? method' do
      @purchase_order.confirmed!
      expect(@purchase_order.delivered?).to eq false
    end
  end
end