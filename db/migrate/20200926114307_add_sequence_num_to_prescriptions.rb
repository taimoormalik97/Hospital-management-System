class AddSequenceNumToPrescriptions < ActiveRecord::Migration[6.0]
  
  
  def self.up
    add_column :prescriptions, :sequence_num, :integer, null: false
    add_index :prescriptions, [:hospital_id, :sequence_num], unique: true
  end

  def self.down
    remove_index  :prescriptions, column: [:hospital_id, :sequence_num]
    remove_column :prescriptions, :sequence_num
  end
end
