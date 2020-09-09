class Availability < ApplicationRecord
  belongs_to :doctor
  belongs_to :hospital
  has_many :appointments, dependent: :destroy
end
