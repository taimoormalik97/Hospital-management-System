class LabReport < ApplicationRecord
	sequenceid :hospital , :labreports
  belongs_to :patient
  belongs_to :test
  belongs_to :hospital
end
