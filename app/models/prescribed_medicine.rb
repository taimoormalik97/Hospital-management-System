class PrescribedMedicine < ApplicationRecord
  belongs_to :appointment
  belongs_to :medicine
  belongs_to :hospital
end
