class CreateInterconnects < ActiveRecord::Migration
  def change
    create_table :interconnects do |t|
      t.integer :user_id
      t.string :provider
      t.string :uuid
      t.string :token

      t.timestamps null: false
    end
    add_index :interconnects, :uuid
    add_index :interconnects, :token
  end
end
