class PurchaseDetail < ApplicationRecord
	sequenceid :hospital , :purchase_details
  belongs_to :hospital
  belongs_to :purchase_order
  belongs_to :medicine
end
