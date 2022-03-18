class CreatePersonalOpinions < ActiveRecord::Migration[6.1]
  def change
    create_table :personal_opinions do |t|
      t.integer :discuss_record_id, null: false
      t.integer :user_id, null: false
      t.text :claim, null: false
      t.text :conclude, null: false
      t.timestamps
    end
  end
end
