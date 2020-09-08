class Bill < ApplicationRecord
  belongs_to :patient
  has_many :bill_details as: :billable, dependent: :destroy
  has_many :medicines through: :bill_details
  has_many :tests through: :bill_details
  has_many :doctors through: :bill_details

end

