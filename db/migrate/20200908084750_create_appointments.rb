class CreateAppointments < ActiveRecord::Migration[6.0]
  def change
    create_table :appointments do |t|
      t.date :date, null: false
      t.references :doctor, null: false, foreign_key: true
      t.references :patient, null: false, foreign_key: true
      t.references :availability, null: false, foreign_key: true
      t.references :hospital, null: false, foreign_key: true

      t.timestamps null: false
    end
    add_index :appointments, :hospital_id
  end
end
