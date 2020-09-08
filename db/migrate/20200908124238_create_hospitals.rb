class CreateHospitals < ActiveRecord::Migration[6.0]
  def change
    create_table :hospitals do |t|
      t.string :name
      t.string :address
      t.bigint :phone_number

      t.timestamps
    end
  end
end
