class AddPrescriptionToPrescribedMedicines < ActiveRecord::Migration[6.0]
  def change
    remove_reference :prescribed_medicines, :appointment
    add_reference :prescribed_medicines, :prescription, foreign_key: true, null:false
  end
end
