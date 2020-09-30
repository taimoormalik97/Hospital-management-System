class AddPriceToBills < ActiveRecord::Migration[6.0]
  def change
    add_column :bills, :price, :decimal
  end
end
