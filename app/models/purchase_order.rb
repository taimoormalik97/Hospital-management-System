class PurchaseOrder < ApplicationRecord
  include ActiveModel::Transitions

  state_machine do
    state :drafted
    state :confirmed
    state :delivered
    event :confirm do
      transitions to: :confirmed, from: :drafted
    end
    event :deliver do
      transitions to: :delivered, from: :confirmed
    end
  end
  sequenceid :hospital, :purchase_orders
  validates :vendorname, presence: { message: 'must be given' }
  validates :price, presence: true, numericality: { greater_than: -1 }
  validates :state, presence: true
  belongs_to :hospital
  belongs_to :admin
  has_many :purchase_details, dependent: :destroy
  has_many :medicines, through: :purchase_details
  
  def add_medicine(medicine, quantity_added)
    begin
      PurchaseOrder.transaction do
        if quantity_added > 0 && self.update(price: self.price += medicine.price*quantity_added)
          curr_purchase_detail = purchase_details.find_by(medicine: medicine)
          if curr_purchase_detail
            updated_quantity = quantity_added + curr_purchase_detail.quantity
            curr_purchase_detail.update(quantity: updated_quantity)
          else
            purchase_details.create(quantity: quantity_added, medicine: medicine, hospital: medicine.hospital)
          end
        else
          self.errors.add(:base, I18n.t('medicine.add.failure'))
          return false
        end
      end
    rescue ActiveRecord::RecordNotSaved
      self.errors.add(:base, I18n.t('medicine.add.failure'))
    end   
  end
  
  def remove_medicine(medicine)
    begin
      PurchaseOrder.transaction do
        curr_purchase_detail = purchase_details.find_by(medicine: medicine)
        if curr_purchase_detail
          price = curr_purchase_detail.medicine.price * curr_purchase_detail.quantity
          if curr_purchase_detail.delete
            update(price: self.price - price)
          end
        else
          self.errors.add(:base, I18n.t('medicine.delete.failure'))
        end
      end
    rescue ActiveRecord::RecordNotSaved
      self.errors.add(:base, I18n.t('medicine.add.failure'))
      return false
    end
  end
end
