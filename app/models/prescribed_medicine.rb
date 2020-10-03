class PrescribedMedicine < ApplicationRecord
  sequenceid :hospital, :prescribed_medicines
  belongs_to :prescription
  belongs_to :medicine
  belongs_to :hospital
  validates_presence_of %i[quantity usage_instruction]
  validates :quantity, numericality: { only_integer: true, greater_than: 0 }
end
