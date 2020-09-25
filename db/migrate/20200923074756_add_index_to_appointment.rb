class AddIndexToAppointment < ActiveRecord::Migration[6.0]
  def change
    add_index :appointments, [:date, :availability_id], unique: true
  end
end
