class AddSequenceNumToMedicines < ActiveRecord::Migration[6.0]
  
  
  def self.up
    add_column :medicines, :sequence_num, :integer, null: false
    update_sequence_num_values
    add_index :medicines, [:sequence_num,:hospital_id], unique: true
  end

  def self.down
    remove_index  :medicines, column: [:sequence_num, :hospital_id]
    remove_column :medicines, :sequence_num
  end

  def self.update_sequence_num_values
    Hospital.all.each do |parent|
      cntr = 1
      parent.medicines.reorder("id").all.each do |nested|
        nested.sequence_num = cntr
        cntr += 1
        nested.save
      end
    end
  end
end

