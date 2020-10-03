module AvailabilityHelper
  def availability_list(doctor_id, date, hospital)
    hospital.availabilities.where(doctor_id: doctor_id, week_day: date)
  end
  
  def convert_to_twelve_hour_format(slot_time)
  	slot_time.strftime("%I:%M%p")
  end

  def active_tab_class(number, active_tab)
  	Date::DAYNAMES[number] == active_tab ? 'active' : ''
  end
end
