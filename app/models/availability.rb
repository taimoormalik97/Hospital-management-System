class Availability < ApplicationRecord
	sequenceid :hospital , :availabilities
  belongs_to :doctor
  belongs_to :hospital
  has_many :appointments, dependent: :destroy
  default_scope { where(hospital_id: Hospital.current_id) }
end
