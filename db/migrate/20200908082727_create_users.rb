class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password, null: false
      t.string :type, null: false
      t.string :gender
      t.date :dob
      t.text :family_history
      t.string :registration_no
      t.string :speciality
      t.decimal :consultancy_fee, precision: 10, scale: 2
      t.references :hospital, null: false

      t.timestamps null: false
    end
    add_index :users, [:id, :type]
  end
end
