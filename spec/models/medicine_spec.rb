require 'rails_helper'
require 'factory_girl_rails'

RSpec.describe Medicine, type: :model do
  context 'validations' do
  	before(:each) do
  		@hospital = Hospital.create(FactoryGirl.attributes_for(:hospital))
  		@medicine_params = FactoryGirl.attributes_for(:medicine)
  		@medicine_params[:hospital]=@hospital
  		@medicine=@hospital.medicines.create(@medicine_params)
  	end
  	it 'should return true when validations pass' do
      expect(@medicine.save).to eq true # fails validation
    end

    it 'should return false when validations fail' do
      expect(@medicine.save).to eq false
    end
  end
  context 'methods' do
  	before(:each) do
  		@hospital = Hospital.create(FactoryGirl.attributes_for(:hospital))
  		@medicine_params = FactoryGirl.attributes_for(:medicine)
  		@medicine_params[:hospital]=@hospital
  		@medicine=@hospital.medicines.create(@medicine_params)
  	end
  end
end