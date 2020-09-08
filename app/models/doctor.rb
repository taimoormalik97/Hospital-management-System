class Doctor < User
  has_many :appointments, dependent: :nullify
  has_many :patients, through: :appointments
  has_many :feedbacks, dependent: :destroy
  has_many :availabilities, dependent: :destroy
  has_many :bill_details as: :billable, dependent: :nullify
  has_many :bills through: :bill_nullify

end
