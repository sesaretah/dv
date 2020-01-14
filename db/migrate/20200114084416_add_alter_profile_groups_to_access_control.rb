class AddAlterProfileGroupsToAccessControl < ActiveRecord::Migration
  def change
    add_column :access_controls, :alter_profile_groups, :integer
  end
end
