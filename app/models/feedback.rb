class Feedback < ApplicationRecord
	sequenceid :hospital , :feedbacks
  belongs_to :hospital
  belongs_to :doctor
  belongs_to :appointment
end
