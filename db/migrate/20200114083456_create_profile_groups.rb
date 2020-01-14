class CreateProfileGroups < ActiveRecord::Migration
  def change
    create_table :profile_groups do |t|
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
