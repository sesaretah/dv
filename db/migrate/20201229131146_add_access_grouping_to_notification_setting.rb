class AddAccessGroupingToNotificationSetting < ActiveRecord::Migration
  def change
    add_column :notification_settings, :access_grouping, :boolean
  end
end
