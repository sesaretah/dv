class AddNotify2ToAccessGrouping < ActiveRecord::Migration
  def change
    add_column :access_groupings, :notify, :boolean
  end
end
