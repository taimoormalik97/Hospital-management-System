class Bill < ApplicationRecord
  sequenceid :hospital , :bills
  belongs_to :hospital
  belongs_to :patient
  has_many :bill_details, dependent: :destroy
  has_many :medicines, through: :bill_details, source: :billable, source_type: 'Medicine'
  has_many :tests, through: :bill_details, source: :billable, source_type: 'Test'
  has_many :doctors, through: :bill_details, source: :billable, source_type: 'Doctor'
  default_scope { where(hospital_id: Hospital.current_id) }
  def add_medicine(medicine, quantity_added)
    if medicine.quantity>0 && quantity_added<=medicine.quantity
      if medicine.update(quantity: medicine.quantity-quantity_added)
        self.update(price: self.price+=medicine.price*quantity_added)
        curr_bd=bill_details.find_by(billable: medicine)
        if curr_bd
          curr_bd.update(quantity:quantity_added+curr_bd.quantity)
        else
          bill_details.create(quantity: quantity_added, billable:medicine, hospital: medicine.hospital) 
        end       
      end
    else
      flash[:error]= t('medicine.add.failure')
    end
  end

  def add_doctor(doctor)
    self.update(price: self.price+=doctor.consultancy_fee)
    bill_details.create(billable: doctor, hospital: doctor.hospital)
  end
end

