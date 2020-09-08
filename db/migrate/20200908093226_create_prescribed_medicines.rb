class CreatePrescribedMedicines < ActiveRecord::Migration[6.0]
  def change
    create_table :prescribed_medicines do |t|
      t.references :appointment, null: false, foreign_key: true
      t.references :medicine, null: false, foreign_key: true
      t.string :usage_instruction

      t.timestamps
    end
  end
end
