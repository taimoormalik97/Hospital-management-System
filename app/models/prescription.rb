class Prescription < ApplicationRecord
	sequenceid :hospital , :prescriptions
  sequenceid :hospital, :prescriptions
  belongs_to :appointment
  belongs_to :hospital
  has_many :prescribed_medicines, dependent: :destroy
  has_many :medicines, through: :prescribed_medicines
  default_scope { where(hospital_id: Hospital.current_id) }
end
