class Availability < ApplicationRecord
  DEFAULT_WEEK_DAY = 'Sunday'.freeze
  sequenceid :hospital, :availabilities
  belongs_to :doctor
  belongs_to :hospital
  has_many :appointments, dependent: :destroy
  scope :slots_for_a_day, ->(days_num) { where(week_day: days_num) }
  validates_presence_of %i[start_slot end_slot week_day]
  validate :invalid_slot
  before_destroy :check_availability_for_appointments
  
  def invalid_slot
    starting = (start_slot + 1.minute).strftime('%H%M')
    ending = (end_slot - 1.minute).strftime('%H%M')
    availabilities = doctor.availabilities.where(week_day: week_day)
    availabilities.each do |availability|
      if starting.between?(availability.start_slot.strftime('%H%M'), availability.end_slot.strftime('%H%M')) || ending.between?(availability.start_slot.strftime('%H%M'), availability.end_slot.strftime('%H%M'))
        errors.add(:base, I18n.t('availability.overlapping_error'))
      end
    end
  end

  def breakslots
    starting = start_slot
    ending = start_slot + 30.minute
    slots_end = end_slot
    if start_slot >= slots_end
      errors.add(:base, I18n.t('availability.end_time_error'))
      return false
    end
    availability = self
    availability.end_slot = ending
    while slots_end >= ending
      return false unless availability.save

      availability = Availability.new(week_day: week_day, doctor_id: doctor.id)
      starting = ending
      ending = starting + 30.minute
      availability.start_slot = starting
      availability.end_slot = ending
    end
    true
  end

  def check_availability_for_appointments
    return true if appointments.blank?

    errors.add :base, I18n.t('doctor.delete.appointment_error')
    throw(:abort)
  end
end
