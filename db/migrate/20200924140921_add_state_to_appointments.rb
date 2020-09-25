class AddStateToAppointments < ActiveRecord::Migration[6.0]
  def change
  	add_column :appointments, :state, :string
  end
end
