class Patient < User
  before_destroy :check_appointments_of_patient
  has_many :appointments, dependent: :nullify
  has_many :doctors, through: :appointments
  has_many :bills, dependent: :nullify
  validates_presence_of %i[name gender dob]
  validates :dob, timeliness: { on_or_before: lambda { Date.today }, type: :date }
  scope :doctor_only, ->(user) { joins(:appointments).where(appointments: { doctor_id: user.id, hospital_id: user.hospital_id }).distinct }
  
  def self.search_patients(pattern)
    if pattern.blank?  # blank? covers both nil and empty string
      all
    else
      where('name LIKE ?', "%#{pattern}%").limit(TOKENINPUT_LIMIT)
    end
  end

  def check_appointments_of_patient
    return true if appointments.blank?

    errors.add :base, I18n.t('patient.delete.appointment_error')
    throw(:abort)
  end
end
