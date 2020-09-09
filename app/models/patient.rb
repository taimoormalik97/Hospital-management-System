class Patient < User
  has_many :appointments, dependent: :nullify
  has_many :doctors, through: :appointments
  has_many :lab_reports, dependent: :nullify
  has_many :bills, dependent: :nullify
end
