class CreateDiscussRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :discuss_records do |t|
      t.integer :pair_id, null: false
      t.string :title, null: false, default: ""
      t.text :detail, null: false
      t.boolean :is_closed, null: false, default: false
      t.timestamps
    end
  end
end
