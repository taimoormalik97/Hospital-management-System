class PrescribedMedicine < ApplicationRecord
	sequenceid :hospital , :prescribed_medicines
  belongs_to :appointment
  belongs_to :medicine
  belongs_to :hospital
end
