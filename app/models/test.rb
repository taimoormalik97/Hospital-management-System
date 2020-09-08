class Test < ApplicationRecord
	has_many :bill_details as: :billable
	has_many :lab_reports
	has_many :bills, through: :bill_details

end
