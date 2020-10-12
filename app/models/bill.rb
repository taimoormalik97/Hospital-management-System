class Bill < ApplicationRecord
  sequenceid :hospital, :bills
  belongs_to :hospital
  belongs_to :patient
  validates :billable_type, inclusion: { in: ['medicine', 'doctor'], message: 'Not a valid billable type' }
  has_many :bill_details, dependent: :destroy
  has_many :medicines, through: :bill_details, source: :billable, source_type: 'Medicine'
  has_many :doctors, through: :bill_details, source: :billable, source_type: 'Doctor'
  
  def add_medicine(medicine, quantity_added)
    begin
      Bill.transaction do
        if quantity_added > 0 && medicine.quantity > 0 && quantity_added <= medicine.quantity
          if medicine.update!(quantity: medicine.quantity - quantity_added)
            updated_price = price + (medicine.price * quantity_added)
            update!(price: updated_price)
            curr_bill_detail = bill_details.find_by(billable: medicine)
            if curr_bill_detail
              curr_bill_detail.update(quantity: quantity_added + curr_bill_detail.quantity)
            else
              bill_details.create(quantity: quantity_added, billable: medicine, hospital: medicine.hospital)
            end
          end
        else
          errors.add :base, I18n.t('medicine.add.failure')
          return false
        end
      end
    rescue => e
      errors.add :base, I18n.t('medicine.add.failure')
    end
  end

  def add_doctor(doctor)
    curr_bill_detail = bill_details.find_by(billable: doctor)
    if curr_bill_detail
      errors.add(:unable_to_add, I18n.t('doctor.add.failure'))
      return false
    else
      update(price: self.price + doctor.consultancy_fee)
      bill_details.create(billable: doctor, hospital: doctor.hospital)
    end
  end

  def medicine_bill?
    billable_type == 'medicine'
  end
end
