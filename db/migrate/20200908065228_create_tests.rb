class CreateTests < ActiveRecord::Migration[6.0]
  def change
    create_table :tests do |t|
      t.string :name,  null: false
      t.string :details,  null: false
      t.decimal :price, precision: 10, scale: 2,  null: false

      t.timestamps
    end
    add_index :tests, :name
  end
end
