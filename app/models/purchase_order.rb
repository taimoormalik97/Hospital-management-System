class PurchaseOrder < ApplicationRecord
  belongs_to :hospital
  belongs_to :admin
  has_many :purchase_details, dependent: :destroy
  has_many :medicines, through: :purchase_details
  default_scope { where(hospital_id: Hospital.current_id) }
end