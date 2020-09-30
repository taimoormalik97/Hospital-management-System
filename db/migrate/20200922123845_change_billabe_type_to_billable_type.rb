class ChangeBillabeTypeToBillableType < ActiveRecord::Migration[6.0]
  def change
  	rename_column :bills, :billabe_type, :billable_type
  end
end
