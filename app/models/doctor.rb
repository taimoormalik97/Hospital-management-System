class Doctor < User
  has_many :appointments, dependent: :destroy
  has_many :patients, through: :appointments
  has_many :feedbacks, dependent: :destroy
  has_many :availabilities, dependent: :destroy
  has_many :bill_details as: :billable, dependent: :destroy
  has_many :bills through: :bill_details
  
end
