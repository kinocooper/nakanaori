class CreatePairs < ActiveRecord::Migration[6.1]
  def change
    create_table :pairs do |t|
      t.string :name, null: false, default: ""
      t.text :motto, null: false
      t.string :keyword, null:false, default:""
      t.integer :pair_type, null: false, default: 0
      t.boolean :is_paired, null: false, default: false
      t.integer :rank, null: false, default: 0
      t.timestamps
    end
  end
end
