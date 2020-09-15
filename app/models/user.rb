class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable, 
  belongs_to :hospital
  accepts_nested_attributes_for :hospital
  validates_format_of :email, with: /\A[^@\s]+@[^@\s]+\z/
  validates :email, uniqueness: { scope: :hospital_id }, presence: true
  validates :name, length: { minimum: 3 }, presence: true
  validates :password, confirmation: true
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable,
         :confirmable, :validatable
  default_scope { where(hospital_id: Hospital.current_id) }

  def admin?
    type == 'Admin'
  end

  def doctor?
    type == 'Patient'
  end

  def patient?
    type == 'Doctor'
  end

# Added these function because devise was always checking for uniqueness of email, but in our product,
# there can be same emails in different domain. So we have have set devise email validation to false.
  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end

end
