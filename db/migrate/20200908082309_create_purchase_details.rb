class CreatePurchaseDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_details do |t|
      t.integer :quantity
      t.references :purchase_order, null: false, foreign_key: true
      t.references :medicine, null: false, foreign_key: true
      t.references :hospital, foreign_key: true, null:false
      t.timestamps, null: false
    end
    add_index(:purchase_details, [:hospital_id, :purchase_order_id])
  end
end
