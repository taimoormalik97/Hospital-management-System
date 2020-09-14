class Availability < ApplicationRecord
  belongs_to :doctor
  belongs_to :hospital
  has_many :appointments, dependent: :destroy
  default_scope { where(hospital_id: Hospital.current_id) }
end
