class AddCurrentRoleIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :current_role_id, :integer
  end
end
