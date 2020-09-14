class PurchaseDetail < ApplicationRecord
  belongs_to :hospital
  belongs_to :purchase_order
  belongs_to :medicine
  default_scope { where(hospital_id: Hospital.current_id) }
end
