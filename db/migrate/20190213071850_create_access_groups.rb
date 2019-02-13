class CreateAccessGroups < ActiveRecord::Migration
  def change
    create_table :access_groups do |t|
      t.string :title
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
