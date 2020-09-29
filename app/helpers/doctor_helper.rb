module DoctorHelper
  def list_of_doctors_with_speciality(doctors, speciality)
    if speciality.present? 
      doctors.where(speciality: speciality) 
    else 
      doctors
    end
  end
end
