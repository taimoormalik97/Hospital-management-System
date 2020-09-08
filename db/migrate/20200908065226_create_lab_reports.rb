class CreateLabReports < ActiveRecord::Migration[6.0]
  def change
    create_table :lab_reports do |t|
      t.references :patient, null: false, foreign_key: true
      t.references :test, null: false, foreign_key: true
      t.datetime :sample_collection_date,  null: false
      t.datetime :report_generation_date, null: false

      t.timestamps
    end
  end
end
