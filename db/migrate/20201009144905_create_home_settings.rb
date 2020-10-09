class CreateHomeSettings < ActiveRecord::Migration
  def change
    create_table :home_settings do |t|
      t.integer :user_id
      t.integer :pp
      t.string :sort
      t.integer :workflow_state

      t.timestamps null: false
    end
  end
end
