module PrescriptionHelper
  def check_persisted_prescription(appointment)
    prescription = get_persisted_prescription(appointment)
    prescription.blank?
  end

  def get_persisted_prescription(appointment)
    Prescription.find_by(appointment_id: appointment.id)
  end

end
