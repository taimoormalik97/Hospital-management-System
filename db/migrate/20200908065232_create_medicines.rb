class CreateMedicines < ActiveRecord::Migration[6.0]
  def change
    create_table :medicines do |t|
      t.string :name
      t.integer :quantity
      t.decimal :price, precision: 10, scale: 2

      t.timestamps
    end
  end
end
