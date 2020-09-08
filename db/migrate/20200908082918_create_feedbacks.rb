class CreateFeedbacks < ActiveRecord::Migration[6.0]
  def change
    create_table :feedbacks do |t|
      t.references :hospital, null: false, foreign_key: true
      t.references :doctor, null: false, foreign_key: true
      t.text :feedback_detail, null: false

      t.timestamps
    end
  end
end
