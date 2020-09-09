class PurchaseOrder < ApplicationRecord
  belongs_to :hospital
  belongs_to :admin
  has_many :purchase_details, dependent: :destroy
  has_many :medicines through: :purchase_details
end