class Doctor < User
  has_many :appointments
  has_many :patients, through: :appointments
  has_many :feedbacks
  has_many :availabilities
  has_many :bill_details as: :billable
  has_many :bills through: :bill_details
  
end
