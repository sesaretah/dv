class CreateTaggings < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :taggable_id
      t.string :taggable_type
      t.integer :target_id
      t.string :target_type

      t.timestamps null: false
    end
  end
end
