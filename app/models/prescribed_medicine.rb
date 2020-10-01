class PrescribedMedicine < ApplicationRecord
  sequenceid :hospital, :prescribed_medicines
  belongs_to :prescription
  belongs_to :medicine
  belongs_to :hospital
  default_scope { where(hospital_id: Hospital.current_id) }
end
