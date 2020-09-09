class CreateMedicines < ActiveRecord::Migration[6.0]
  def change
    create_table :medicines do |t|
      t.string :name, null: false
      t.integer :quantity, null: false
      t.decimal :price, precision: 10, scale: 2, null: false
      t.references :hospital, null: false, foreign_key: true

      t.timestamps null: false
    end
    add_index :medicines, [:hospital_id, :id]
  end
end
