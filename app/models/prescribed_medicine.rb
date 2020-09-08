class PrescribedMedicine < ApplicationRecord
  belongs_to :appointment
  belongs_to :medicine
end
