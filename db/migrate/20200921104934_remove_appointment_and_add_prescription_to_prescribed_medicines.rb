class RemoveAppointmentAndAddPrescriptionToPrescribedMedicines < ActiveRecord::Migration[6.0]
  def change
    remove_reference :prescribed_medicines, :appointment
    add_reference :prescribed_medicines, :prescription, null:false
  end
end
