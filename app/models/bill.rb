class Bill < ApplicationRecord
  belongs_to :hospital
  belongs_to :patient
  has_many :bill_details, dependent: :destroy
  has_many :medicines, through: :bill_details, source: :billable, source_type: 'Medicine'
  has_many :tests, through: :bill_details, source: :billable, source_type: 'Test'
  has_many :doctors, through: :bill_details, source: :billable, source_type: 'Doctor'
  default_scope { where(hospital_id: Hospital.current_id) }
end

