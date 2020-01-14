class CreateProfileGroupings < ActiveRecord::Migration
  def change
    create_table :profile_groupings do |t|
      t.integer :profile_id
      t.integer :profile_group_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
