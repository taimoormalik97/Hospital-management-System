class Feedback < ApplicationRecord
  belongs_to :hospital
  belongs_to :doctor
  belongs_to :appointment
end
