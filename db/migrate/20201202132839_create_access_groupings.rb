class CreateAccessGroupings < ActiveRecord::Migration
  def change
    create_table :access_groupings do |t|
      t.integer :access_group_id
      t.integer :article_id
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :access_groupings, :access_group_id
  end
end
