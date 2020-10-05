class ChangePriceInBills < ActiveRecord::Migration[6.0]
  def change
  	change_column_default :bills, :price, 0
  end
end
