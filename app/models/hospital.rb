class Hospital < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :appointments, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  has_many :availability, dependent: :destroy
  has_many :lab_reports, dependent: :destroy
  has_many :tests, dependent: :destroy
  has_many :medicines, dependent: :destroy
  has_many :prescribed_medicines, dependent: :destroy
  has_many :purchase_orders, dependent: :destroy
  has_many :purchase_details, dependent: :destroy
  has_many :bills, dependent: :destroy
  has_many :bill_details, dependent: :destroy
end
