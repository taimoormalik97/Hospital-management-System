class Patient < User
  has_many :appointments, dependent: :destroy
  has_many :doctors, through: :appointments
  has_many :lab_reports, dependent: :destroy
  has_many :bills, dependent: :destroy
end
