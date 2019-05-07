class CreatePublishers < ActiveRecord::Migration
  def change
    create_table :publishers do |t|
      t.string :title
      t.string :description
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
