class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :title
      t.text :content
      t.string :notifiable_id
      t.string :notifiable_type

      t.timestamps null: false
    end
  end
end
