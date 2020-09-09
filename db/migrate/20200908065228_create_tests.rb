class CreateTests < ActiveRecord::Migration[6.0]
  def change
    create_table :tests do |t|
      t.string :name, null: false
      t.string :details, null: false
      t.decimal :price, precision: 10, scale: 2
      t.references :hospital, null: false, foreign_key: true

      t.timestamps null: false
    end
    add_index :tests, :name
    add_index :tests, :hospital
  end
end
