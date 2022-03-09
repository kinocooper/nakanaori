class CreatePairs < ActiveRecord::Migration[6.1]
  def change
    create_table :pairs do |t|
      t.string :name, null: false
      t.text :motto, null: false
      t.integer :pair_type, null: false, default: 0
      t.integer :rank, null: false, default: 0
      t.timestamps
    end
  end
end
