class CreatePurchaseOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :purchase_orders do |t|
      t.string :vendorname
      t.decimal {10,2} :price
      t.string :state
      t.references :admin, null: false, foreign_key: true

      t.timestamps
    end
  end
end
