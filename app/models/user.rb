class User < ApplicationRecord
  sequenceid :hospital, :users
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable, 
  belongs_to :hospital
  accepts_nested_attributes_for :hospital
  validates_format_of :email, with: /\A[^@\s]+@[^@\s]+\z/
  validates :email, uniqueness: { scope: :hospital_id }, presence: true, case_sensitive: false
  validates :name, length: { minimum: 3 }, presence: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :timeoutable,
         :confirmable, :validatable
  default_scope { where(hospital_id: Hospital.current_id) }
  validates :name, length: { in: 3..35 }
  ROLES = { admin: 'Admin', doctor: 'Doctor', patient: 'Patient' }.freeze

# Added these function because devise was always checking for uniqueness of email, but in our product,
# there can be same emails in different domain. So we have have set devise email validation to false.
  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end
  
  def admin?
  	type == ROLES[:admin]
  end
  
  def doctor?
  	type == ROLES[:doctor]
  end
  
  def patient?
  	type == ROLES[:patient]
  end

  def set_reset_password_token
    super
  end

end
