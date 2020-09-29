class Doctor < User
  sequenceid :hospital , :doctors
  has_many :appointments, dependent: :nullify
  has_many :patients, through: :appointments
  has_many :feedbacks, dependent: :destroy
  has_many :availabilities, dependent: :destroy
  has_many :bill_details, as: :billable, dependent: :nullify
  has_many :bills, through: :bill_details
  validates_presence_of %i[name registration_no speciality consultancy_fee]
  validates :consultancy_fee, numericality: true
  validates :registration_no, numericality: { only_integer: true }, uniqueness: { scope: :hospital_id }, case_sensitive: false
  has_attached_file :profile_picture, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment :profile_picture,
    size: { in: 0..10.megabytes },
    content_type: { content_type: /^image\/(jpg|jpeg|png|gif|tiff)$/ }
end
