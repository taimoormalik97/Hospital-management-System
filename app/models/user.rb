class User < ApplicationRecord
  belongs_to :hospital
  ROLES = { admin: 'Admin', doctor: 'Doctor', patient: 'Patient' }.freeze
  def admin?
  	type == ROLES[:admin]
  end
  def doctor?
  	type == ROLES[:doctor]
  end
  def patient?
  	type == ROLES[:patient]
  end
end
