class AddArchivedToHomeSetting < ActiveRecord::Migration
  def change
    add_column :home_settings, :archived, :integer
  end
end
