class Patient < User
  has_many :appointments
  has_many :doctors, through: :appointments
  has_many :lab_reports
  has_many :bills
end
