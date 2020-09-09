class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.date :date, null: false
      t.references :doctor, null: false
      t.references :patient, null: false
      t.references :availability, null: false
      t.references :hospital, null: false

      t.timestamps null: false
    end
  end
end
