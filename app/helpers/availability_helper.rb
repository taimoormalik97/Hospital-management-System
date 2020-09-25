module AvailabilityHelper
  def availability_list(doctor_id, date, hospital)
    hospital.availabilities.where(doctor_id: doctor_id, week_day: date)
  end
  
  def convert_to_twelve_hour_format(slot_time)
  	slot_time.strftime("%I:%M%p")
  end
end
