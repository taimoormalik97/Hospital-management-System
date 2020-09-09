class CreatePurchaseOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_orders do |t|
      t.string :vendorname, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.string :state, null: false
      t.references :admin, null: false
      t.references :hospital, null: false
      t.timestamps null: false
    end
  end
end
