class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :type
      t.string :gender
      t.date :dob
      t.text :family_history
      t.string :registration_no
      t.string :speciality
      t.decimal :consultancy_fee, precision: 10, scale: 2

      t.timestamps
    end
    add_index :users, :name
  end
end
