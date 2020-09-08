class Availability < ApplicationRecord
  belongs_to :doctor
  has_many :appointments, dependent: :destroy
end
