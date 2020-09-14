class PurchaseOrder < ApplicationRecord
	sequenceid :hospital , :purchase_orders
  validates :vendorname, presence: { message: "must be given" }
  validates :price, presence: true, numericality: {:greater_than => 0}
  validates :state, presence: true 
  belongs_to :hospital
  belongs_to :admin
  has_many :purchase_details, dependent: :destroy
  has_many :medicines, through: :purchase_details
  def add_med(medicine)
  	purchase_details.create(quantity: 1, medicine: medicine, hospital: medicine.hospital)
end
end