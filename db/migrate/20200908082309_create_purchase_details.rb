class CreatePurchaseDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_details do |t|
      t.references :purchaseorder, null: false, foreign_key: true
      t.references :medicine, null: false, foreign_key: true
      t.references :hospital, foreign_key: true, null:false
      t.timestamps
    end
  end
end
