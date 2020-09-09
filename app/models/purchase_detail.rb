class PurchaseDetail < ApplicationRecord
  belongs_to :hospital
  belongs_to :purchase_order
  belongs_to :medicine
end
