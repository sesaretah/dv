class AddEmmiterIdToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :emmiter_id, :integer
  end
end
