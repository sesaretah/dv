class AddNotifyAutomationToAccessGrouping < ActiveRecord::Migration
  def change
    add_column :access_groupings, :notify_automation, :boolean
  end
end
