class Hospital < ApplicationRecord
  has_many :users
  has_many :appointments
  has_many :feedbacks
  has_many :availability
  has_many :lab_reports
  has_many :tests
  has_many :medicines
  has_many :prescribed_medicines
  has_many :purchase_orders
  has_many :purchase_details
  has_many :bills
  has_many :bill_details
end
