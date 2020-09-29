class Hospital < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :appointments, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  has_many :availabilities, dependent: :destroy
  has_many :lab_reports, dependent: :destroy
  has_many :tests, dependent: :destroy
  has_many :medicines, dependent: :destroy
  has_many :prescribed_medicines, dependent: :destroy
  has_many :purchase_orders, dependent: :destroy
  has_many :purchase_details, dependent: :destroy
  has_many :bills, dependent: :destroy
  has_many :bill_details, dependent: :destroy
  validates :name, uniqueness: true, length: { minimum: 3 }, case_sensitive: false
  validates :sub_domain, uniqueness: true
  
  def self.current_id=(hospital_id)
    Thread.current[:hospital_id] = hospital_id
  end

  def self.current_id
    Thread.current[:hospital_id]
  end
end
