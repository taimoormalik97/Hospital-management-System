class Medicine < ApplicationRecord
	validates :name, presence: { message: "must be given" }
	validates :price, presence: true, numericality: {:greater_than => 0}
	validates :quantity, presence: true  
	has_many :bill_details, as: :billable, dependent: :nullify
	has_many :prescribed_medicines, dependent: :nullify
	has_many :purchase_details, dependent: :nullify
	belongs_to :hospital
end
