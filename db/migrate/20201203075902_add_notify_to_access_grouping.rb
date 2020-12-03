class AddNotifyToAccessGrouping < ActiveRecord::Migration
  def change
    add_column :access_groupings, :nofity, :boolean
  end
end
