class CreateTags < ActiveRecord::Migration[6.1]
  def change
    create_table :tags do |t|
      t.integer :pair_id, null: false
      t.string :name, null: false, default: ""
      t.timestamps
    end
  end
end
