module DashboardHelper
  def user_profile_path(user)
    if user.admin?
      admin_path(user.id)
    elsif user.doctor?
      doctor_path(user.id)
    elsif user.patient?
      patient_path(user.id)
    end
  end
end
