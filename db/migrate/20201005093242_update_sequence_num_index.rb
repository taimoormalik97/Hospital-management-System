class UpdateSequenceNumIndex < ActiveRecord::Migration[6.0]
  def change
    remove_index :users, [:sequence_num, :hospital_id]
    remove_index :appointments, [:sequence_num, :hospital_id]
    remove_index :availabilities, [:sequence_num, :hospital_id]
    remove_index :bill_details, [:sequence_num, :hospital_id]
    remove_index :bills, [:sequence_num, :hospital_id]
    remove_index :medicines, [:sequence_num, :hospital_id]
    remove_index :prescribed_medicines, [:sequence_num, :hospital_id]
    remove_index :purchase_details, [:sequence_num, :hospital_id]
    remove_index :purchase_orders, [:sequence_num, :hospital_id]

    add_index :users, [:hospital_id, :sequence_num], unique: true
    add_index :appointments, [:hospital_id, :sequence_num], unique: true
    add_index :availabilities, [:hospital_id, :sequence_num], unique: true
    add_index :bill_details, [:hospital_id, :sequence_num], unique: true
    add_index :bills, [:hospital_id, :sequence_num], unique: true
    add_index :medicines, [:hospital_id, :sequence_num], unique: true
    add_index :prescribed_medicines, [:hospital_id, :sequence_num], unique: true
    add_index :purchase_details, [:hospital_id, :sequence_num], unique: true
    add_index :purchase_orders, [:hospital_id, :sequence_num], unique: true
  end
end
