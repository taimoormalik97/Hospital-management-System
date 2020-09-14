class Availability < ApplicationRecord
	sequenceid :hospital , :availabilities
  belongs_to :doctor
  belongs_to :hospital
  has_many :appointments, dependent: :destroy
end
