class CreateNotificationSettings < ActiveRecord::Migration
  def change
    create_table :notification_settings do |t|
      t.integer :user_id
      t.boolean :article_sent
      t.boolean :article_received
      t.boolean :article_refunded
      t.boolean :article_refunded_received
      t.boolean :article_comment
      t.boolean :article_vote

      t.timestamps null: false
    end
    add_index :notification_settings, :user_id
  end
end
