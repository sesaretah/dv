class AddUserIdToProfileGroups < ActiveRecord::Migration
  def change
    add_column :profile_groups, :user_id, :integer
  end
end
