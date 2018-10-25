class CreateWorkflows < ActiveRecord::Migration
  def change
    create_table :workflows do |t|
      t.string :title
      t.text :description
      t.integer :user_id
      t.text :graph_data
      t.text :nodes
      t.text :edges

      t.timestamps null: false
    end
  end
end
