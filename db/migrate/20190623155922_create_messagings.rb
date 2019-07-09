class CreateMessagings < ActiveRecord::Migration
  def change
    create_table :messagings do |t|
      t.integer :recipient_id
      t.integer :message_id
      t.integer :status

      t.timestamps null: false
    end
  end
end
