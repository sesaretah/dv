class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :surename
      t.integer :user_id
      t.string :phone_number
      t.string :cellphone_number

      t.timestamps null: false
    end
  end
end
