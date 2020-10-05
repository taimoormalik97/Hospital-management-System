module AppointmentHelper
  def status_colors(appointment)
    if appointment.pending?
      { text: 'warning', bg: 'pending' }
    elsif appointment.approved?
      { text: 'info', bg: 'approved' }
    elsif appointment.completed?
      { text: 'success', bg: 'completed' }
    else
      { text: 'danger', bg: 'cancelled' }
    end
  end
end