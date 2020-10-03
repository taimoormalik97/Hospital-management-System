class Hospital < ApplicationRecord
  mark_not_multitenant
  has_many :users, dependent: :destroy
  has_many :doctors, class_name: 'Doctor'
  has_many :admins, class_name: 'Admin'
  has_many :patients, class_name: 'Patient'
  has_many :appointments, dependent: :destroy
  has_many :availabilities, dependent: :destroy
  has_many :medicines, dependent: :destroy
  has_many :prescriptions, dependent: :destroy
  has_many :prescribed_medicines, dependent: :destroy
  has_many :purchase_orders, dependent: :destroy
  has_many :purchase_details, dependent: :destroy
  has_many :bills, dependent: :destroy
  has_many :bill_details, dependent: :destroy
  validates :name, uniqueness: true, length: { minimum: 3 }, presence: true, case_sensitive: false
  validates :sub_domain, uniqueness: true, presence: true, case_sensitive: false
  validates :phone_number, presence: true, numericality: { only_integer: true, greater_than: 0 }, length: { minimum: 10, maximum: 15 }
  
  def self.current_id=(hospital_id)
    Thread.current[:hospital_id] = hospital_id
  end

  def self.current_id
    Thread.current[:hospital_id]
  end
end
