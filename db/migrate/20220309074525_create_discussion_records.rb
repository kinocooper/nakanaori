class CreateDiscussionRecords < ActiveRecord::Migration[6.1]
  def change
    create_table :discussion_records do |t|
      t.integer :pair_id, null: false
      t.string :title, null: false
      t.text :detail, null: false
      t.boolean :is_closed, null: false, default: FALSE
      t.timestamps
    end
  end
end
