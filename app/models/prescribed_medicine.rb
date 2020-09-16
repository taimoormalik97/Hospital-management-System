class PrescribedMedicine < ApplicationRecord
  belongs_to :appointment
  belongs_to :medicine
  belongs_to :hospital
  default_scope { where(hospital_id: Hospital.current_id) }
end
