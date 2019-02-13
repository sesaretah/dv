class CreateRoleAccesses < ActiveRecord::Migration
  def change
    create_table :role_accesses do |t|
      t.integer :role_id
      t.integer :access_group_id

      t.timestamps null: false
    end
  end
end
