class Hospital < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :doctors, class_name: 'Doctor'
  has_many :admins, class_name: 'Admin'
  has_many :patients, class_name: 'Patient'
  has_many :appointments, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  has_many :availabilities, dependent: :destroy
  has_many :lab_reports, dependent: :destroy
  has_many :tests, dependent: :destroy
  has_many :medicines, dependent: :destroy
  has_many :prescriptions, dependent: :destroy
  has_many :prescribed_medicines, dependent: :destroy
  has_many :purchase_orders, dependent: :destroy
  has_many :purchase_details, dependent: :destroy
  has_many :bills, dependent: :destroy
  has_many :bill_details, dependent: :destroy
  validates :name, uniqueness: true, length: { minimum: 3 }, presence: true
  validates :sub_domain, uniqueness: true, presence: true
  validates :phone_number, presence: true,
            numericality: true,
            length: { minimum: 10, maximum: 15 }
  validates :address, presence: true, length: { minimum: 5, maximum: 200 }
  def self.current_id=(hospital_id)
    Thread.current[:hospital_id] = hospital_id
  end

  def self.current_id
    Thread.current[:hospital_id]
  end

  def self.current_hospital
    Thread.current[:hospital]
  end

  def self.current_hospital=(hospital)
    Thread.current[:hospital] = hospital
  end
end
