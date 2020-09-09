class CreateBills < ActiveRecord::Migration[6.0]
  def change
    create_table :bills do |t|
      t.string :billabe_type, null: false
      t.references :patient, null: false, foreign_key: true
      t.references :hospital, foreign_key: true, null:false
      t.timestamps, null: false
    end
    add_index(:bills, [:hospital_id, :patient_id])
  end
end
