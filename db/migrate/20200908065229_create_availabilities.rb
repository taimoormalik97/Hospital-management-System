class CreateAvailabilities < ActiveRecord::Migration[6.0]
  def change
    create_table :availabilities do |t|
      t.string :week_day, null: false
      t.datetime :start_slot, null: false
      t.datetime :end_slot, null: false
      t.references :doctor, null: false
      t.references :hospital, null: false

      t.timestamps null: false
    end
    add_index :availabilities, :week_day
  end
end
