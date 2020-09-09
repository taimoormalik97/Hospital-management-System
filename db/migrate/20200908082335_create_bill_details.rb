class CreateBillDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :bill_details do |t|
      t.integer :quantity
      t.references :bill, null: false, foreign_key: true
      t.references :billable, null: false, polymorphic: true
      t.references :hospital, foreign_key: true, null:false
      t.timestamps, null: false
    end
    add_index(:bill_details, [:hospital_id, :bill_id])
  end
end
