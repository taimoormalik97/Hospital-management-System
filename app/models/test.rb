class Test < ApplicationRecord
	has_many :bill_details as: :billable, dependent: :destroy
	has_many :lab_reports, dependent: :destroy
	has_many :bills, through: :bill_details, dependent: :destroy

end
