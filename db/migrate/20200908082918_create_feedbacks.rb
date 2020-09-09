class CreateFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :feedbacks do |t|
      t.text :feedback_detail, null: false
      t.references :doctor, null: false
      t.references :appointment, null: false
      t.references :hospital, null: false

      t.timestamps null: false
    end
  end
end
