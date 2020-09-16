class Medicine < ApplicationRecord
	sequenceid :hospital , :medicines
	validates :name, presence: { message: "must be given" }
	validates :price, presence: true, numericality: {:greater_than => 0}
	validates :quantity, presence: true  
	has_many :bill_details, as: :billable, dependent: :nullify
	has_many :prescribed_medicines, dependent: :nullify
	has_many :purchase_details, dependent: :nullify
	belongs_to :hospital

	def self.search(pattern)
      if pattern.blank?  # blank? covers both nil and empty string
        all
      else
        where('name LIKE ?', "%#{pattern}%")
      end
    end
  default_scope { where(hospital_id: Hospital.current_id) }
end
