class LabReport < ApplicationRecord
  belongs_to :patient
  belongs_to :test
end
