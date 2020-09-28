module PrescriptionHelper
  def check_persisted_prescription(appointment)
    prescription = get_persisted_prescription(appointment)
    if prescription.blank?
      true
    else
      false
    end
  end

  def get_persisted_prescription(appointment)
    prescription = Prescription.find_by(appointment_id: appointment.id)
  end

end
