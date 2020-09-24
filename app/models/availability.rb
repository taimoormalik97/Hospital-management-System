class Availability < ApplicationRecord
  sequenceid :hospital , :availabilities
  belongs_to :doctor
  belongs_to :hospital
  has_many :appointments, dependent: :destroy
  default_scope { where(hospital_id: Hospital.current_id) }
  validate :invalid_slot
  validates_presence_of %i[start_slot end_slot week_day]

  def invalid_slot
    starting = start_slot.strftime("%H%M")
    ending = end_slot.strftime("%H%M")
    if starting >= ending
      errors.add(:base, I18n.t('availability.end_time_error'))
    end
    all_availability = doctor.availabilities.where(week_day: week_day)
    all_availability.each do |event|
      if starting.between?(event.start_slot.strftime("%H%M"), event.end_slot.strftime("%H%M")) || ending.between?(event.start_slot.strftime("%H%M"), event.end_slot.strftime("%H%M"))
      	errors.add(:base, I18n.t('availability.overlapping_error'))
      end
    end
  end
end
