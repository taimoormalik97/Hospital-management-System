class CreateLabReports < ActiveRecord::Migration[6.0]
  def change
    create_table :lab_reports do |t|
      t.references :patient, null: false
      t.references :hospital, null: false
      t.references :test, null: false
      t.datetime :sample_collection_date, null: false
      t.datetime :report_generation_date, null: false

      t.timestamps null: false
    end
    add_index :lab_reports, [:hospital_id, :id]
  end
end
