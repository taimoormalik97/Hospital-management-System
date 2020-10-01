module DoctorHelper

  def profile_picture(doctor)
    doctor.profile_picture.present?
  end
end
