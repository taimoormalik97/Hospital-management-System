class RemoveNullConstraintFromHospital < ActiveRecord::Migration[6.0]
  def change
    change_column :hospitals, :address, :string, null: true
  end
end
