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
end
