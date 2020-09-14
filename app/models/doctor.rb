class Doctor < User
  has_many :appointments, dependent: :nullify
  has_many :patients, through: :appointments
  has_many :feedbacks, dependent: :destroy
  has_many :availabilities, dependent: :destroy
  has_many :bill_details, as: :billable, dependent: :nullify
  has_many :bills, through: :bill_details
  validates_presence_of %i[name registration_no speciality consultancy_fee]
  validates :name, length: { in: 3..35 }
  validates :consultancy_fee, numericality: true
  validates :registration_no, numericality: { only_integer: true }, uniqueness: { scope: :hospital_id }
end
