class CreateBillDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :bill_details do |t|
      t.references :bill, null: false, foreign_key: true
      t.references :billable, null: false, polymorphic: true

      t.timestamps
    end
  end
end
