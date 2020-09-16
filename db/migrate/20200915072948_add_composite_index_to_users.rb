class AddCompositeIndexToUsers < ActiveRecord::Migration[6.0]
  def change
    add_index :users, [:hospital_id, :email]
  end
end
