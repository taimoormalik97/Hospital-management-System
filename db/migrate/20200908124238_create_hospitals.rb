class CreateHospitals < ActiveRecord::Migration[6.0]
  def change
    create_table :hospitals do |t|
      t.string :name, null: false
      t.string :address, null: false
      t.bigint :phone_number, null: false

      t.timestamps
    end
  end
end
