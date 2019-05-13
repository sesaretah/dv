class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :title
      t.integer :user_id
      t.float :longitude
      t.float :latidue
      t.text :description

      t.timestamps null: false
    end
  end
end
