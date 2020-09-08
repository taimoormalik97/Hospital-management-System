class Medicine < ApplicationRecord
	has_many :bill_details as: :billable, dependent: :destroy
	has_many :prescribed_medicines, dependent: :destroy
	has_many :purchase_details, dependent: :destroy
    belongs_to :hospital

end
