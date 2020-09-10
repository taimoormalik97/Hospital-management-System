class PurchaseOrder < ApplicationRecord
  validates :vendorname, presence: { message: "must be given" }
  validates :price, presence: true, numericality: {:greater_than => 0}
  validates :state, presence: true 
  belongs_to :hospital
  belongs_to :admin
  has_many :purchase_details, dependent: :destroy
  has_many :medicines, through: :purchase_details
end