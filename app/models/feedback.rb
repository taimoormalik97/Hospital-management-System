class Feedback < ApplicationRecord
	sequenceid :hospital , :feedbacks
  belongs_to :hospital
  belongs_to :doctor
  belongs_to :appointment
  default_scope { where(hospital_id: Hospital.current_id) }
end
