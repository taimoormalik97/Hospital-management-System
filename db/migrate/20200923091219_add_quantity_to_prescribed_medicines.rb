class AddQuantityToPrescribedMedicines < ActiveRecord::Migration[6.0]
  def change
    add_column :prescribed_medicines, :quantity, :decimal, null: false
  end
end
