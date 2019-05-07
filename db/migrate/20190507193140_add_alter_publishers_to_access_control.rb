class AddAlterPublishersToAccessControl < ActiveRecord::Migration
  def change
    add_column :access_controls, :alter_publishers, :integer
  end
end
