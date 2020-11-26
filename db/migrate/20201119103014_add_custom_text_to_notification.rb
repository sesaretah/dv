class AddCustomTextToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :custom_text, :text
  end
end
