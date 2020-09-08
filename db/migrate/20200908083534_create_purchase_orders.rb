class CreatePurchaseOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_orders do |t|
      t.string :vendorname, null: false
      t.decimal {10,2} :price, null: false
      t.string :state, null: false
      t.references :admin, null: false, foreign_key: true
      t.references :hospital, foreign_key: true, null:false
      t.timestamps
    end
  end
end
