class CreateTests < ActiveRecord::Migration[6.0]
  def change
    create_table :tests do |t|
      t.string :name
      t.string :details
      t.decimal :price, precision: 10, scale: 2

      t.timestamps
    end
    add_index :tests, :name
  end
end
