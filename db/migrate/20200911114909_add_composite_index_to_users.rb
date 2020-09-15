class AddCompositeIndexToUsers < ActiveRecord::Migration[6.0]
  def change
    add_index :users, [:email, :hospital_id]
  end
end
