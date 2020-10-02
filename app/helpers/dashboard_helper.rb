module DashboardHelper
  def user_profile_path(user)
    if user.admin?
      admin_path(user.sequence_num)
    elsif user.doctor?
      doctor_path(user.sequence_num)
    elsif user.patient?
      patient_path(user.sequence_num)
    end
  end

  def count_doctors(hospital)
    hospital.doctors.count
  end

  def count_medicines(hospital)
    hospital.medicines.count
  end

  def count_appointments(hospital)
    hospital.appointments.count
  end

  def calculate_revenue(hospital)
    hospital.bills.pluck(:price).sum
  end

  def count_user_appointments(user)
    user.appointments.count
  end

  def count_patient_orders(patient)
    patient.bills.where(billable_type: 'medicine').count
  end

  def count_doctor_patients(doctor)
    doctor.appointments.pluck(:patient_id).uniq.count
  end

  def calculate_doctor_revenue(doctor)
    bills = doctor.bill_details.pluck(:bill_id).uniq.collect do |bill_id|
      @current_hospital.bills.where(id: bill_id).pluck(:price)
    end
    bills.sum
  end

  def doctor_revenue_per_day(doctor)
    bills = doctor.bill_details.pluck(:bill_id).uniq.collect do |bill_id|
      @current_hospital.bills.find_by(id: bill_id)
    end
  end

end
