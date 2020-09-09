class CreatePrescribedMedicines < ActiveRecord::Migration[6.0]
  def change
    create_table :prescribed_medicines do |t|
      t.references :appointment, null: false
      t.references :medicine, null: false
      t.string :usage_instruction, null: false
      t.references :hospital, null: false

      t.timestamps null: false
    end
  end
end
