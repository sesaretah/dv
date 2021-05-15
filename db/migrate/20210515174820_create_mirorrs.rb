class CreateMirorrs < ActiveRecord::Migration
  def change
    create_table :mirorrs do |t|
      t.integer :source_state
      t.integer :target_state
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
