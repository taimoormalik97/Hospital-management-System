class Hospital < ApplicationRecord
  has_many :users
  has_many :appointments
  has_many :feedbacks
  has_many :availability
  has_many :lab_report
  has_many :test
  has_many :medicine 
  has_many :prescribed_medicine
  has_many :purchase_order
  has_many :purchase_detail
  has_many :bill
  has_many :bill_detail
end
