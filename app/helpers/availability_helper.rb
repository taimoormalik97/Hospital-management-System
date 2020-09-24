module AvailabilityHelper
  def availability_list(doctor_id, date)
    Availability.where(doctor_id: doctor_id, week_day: date).all
  end
end
