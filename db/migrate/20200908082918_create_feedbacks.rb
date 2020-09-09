class CreateFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :feedbacks do |t|
      t.text :feedback_detail, null: false
      t.references :doctor, null: false, foreign_key: true
      t.references :appointment, null: false, foreign_key: true
      t.references :hospital, null: false, foreign_key: true

      t.timestamps
    end
    add_index :feedbacks, :hospital_id
  end
end
