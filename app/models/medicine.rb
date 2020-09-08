class Medicine < ApplicationRecord
	has_many :bill_details as: :billable
	has_many :prescribed_medicines
	has_many :purchase_details
end
