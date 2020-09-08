class CreateBills < ActiveRecord::Migration[6.0]
  def change
    create_table :bills do |t|
      t.string :Billabe_type, null: false
      t.references :patient, null: false, foreign_key: true
      t.references :hospital, foreign_key: true
      t.timestamps
    end
  end
end
