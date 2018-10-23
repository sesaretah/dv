class CreateKinships < ActiveRecord::Migration
  def change
    create_table :kinships do |t|
      t.integer :user_id
      t.integer :kin_id

      t.timestamps null: false
    end
  end
end
