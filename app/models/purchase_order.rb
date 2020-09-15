class PurchaseOrder < ApplicationRecord
  include ActiveModel::Transitions

  state_machine do
    state :drafted
    state :confirmed
    state :delivered
    event :confirmed do
      transitions to: :confirmed, from: :drafted
    end
    event :delivered do
      transitions to: :delivered, from: :confirmed
    end
  end
  sequenceid :hospital , :purchase_orders
  validates :vendorname, presence: { message: "must be given" }
  validates :price, presence: true, numericality: {:greater_than => 0}
  validates :state, presence: true 
  belongs_to :hospital
  belongs_to :admin
  has_many :purchase_details, dependent: :destroy
  has_many :medicines, through: :purchase_details
  def add_medicine(medicine)
  	if medicine.quantity>0
      if medicine.update(quantity: medicine.quantity-1)
        self.update(price: self.price+=medicine.price)   
  	    purchase_details.create(quantity: 1, medicine: medicine, hospital: medicine.hospital)        
  	  end
  	else
  		flash[:error]= t('medicine.add.failure')
    end
 end
end