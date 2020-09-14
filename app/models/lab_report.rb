class LabReport < ApplicationRecord
  belongs_to :patient
  belongs_to :test
  belongs_to :hospital
  default_scope { where(hospital_id: Hospital.current_id) }
end
