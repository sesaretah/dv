class AddAlterPublishSourcesToAccessControl < ActiveRecord::Migration
  def change
    add_column :access_controls, :alter_publish_sources, :integer
  end
end
