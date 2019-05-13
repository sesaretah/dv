class AddAlterLocationsToAccessControl < ActiveRecord::Migration
  def change
    add_column :access_controls, :alter_locations, :integer
  end
end
