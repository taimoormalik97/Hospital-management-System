class PurchaseOrder < ApplicationRecord
  belongs_to :admin
  has_many :purchase_details
  has_many :medicines through: :purchase_details
end
