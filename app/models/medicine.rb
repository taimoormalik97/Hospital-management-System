class Medicine < ApplicationRecord
  before_destroy :check_medicines_in_prescription
  sequenceid :hospital, :medicines
  validates :name, presence: { message: 'must be given' }
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  has_many :bill_details, as: :billable, dependent: :nullify
  has_many :prescribed_medicines, dependent: :nullify
  has_many :purchase_details, dependent: :nullify
  belongs_to :hospital

  def self.search_medicine(pattern)
    if pattern.blank?  # blank? covers both nil and empty string
      all
    else
      where('name LIKE ?', "%#{pattern}%")
    end
  end

  def check_medicines_in_prescription
    return true if prescribed_medicines.blank?

    errors.add :base, I18n.t('medicine.prescription_error')
    throw(:abort)
  end
end
