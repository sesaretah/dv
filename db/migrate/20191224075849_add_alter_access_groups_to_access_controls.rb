class AddAlterAccessGroupsToAccessControls < ActiveRecord::Migration
  def change
    add_column :access_controls, :alter_access_groups, :integer
  end
end
