class CreatePrescriptions < ActiveRecord::Migration[6.0]
  def change
    create_table :prescriptions do |t|
      t.text :notes
      t.references :appointment, null: false
      t.references :hospital, null: false

      t.timestamps, null: false
    end
  end
end
