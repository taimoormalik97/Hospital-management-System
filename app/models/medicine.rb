class Medicine < ApplicationRecord
	has_many :bill_details, as: :billable, dependent: :nullify
	has_many :prescribed_medicines, dependent: :nullify
	has_many :purchase_details, dependent: :nullify
	belongs_to :hospital
  default_scope { where(hospital_id: Hospital.current_id) }
end
