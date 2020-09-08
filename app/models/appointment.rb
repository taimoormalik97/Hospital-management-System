class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient
  belongs_to :availability
  has_many :prescribed_medicines
  has_many :medicines through: :prescribed_medicines

end
