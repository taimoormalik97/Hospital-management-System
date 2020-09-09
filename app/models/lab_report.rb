class LabReport < ApplicationRecord
  belongs_to :patient
  belongs_to :test
  belongs_to :hospital
end
