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
  ROLES = { admin: 'Admin', doctor: 'Doctor', patient: 'Patient' }.freeze
  has_attached_file :profile_picture, styles: { medium: "300x300>", thumb: "100x100>" }
  validates_attachment :profile_picture,
    size: { in: 0..10.megabytes },
    content_type: { content_type: /^image\/(jpg|jpeg|png|gif|tiff)$/ 
  }

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
