class AddUserIdToDuty < ActiveRecord::Migration
  def change
    add_column :duties, :user_id, :integer
  end
end
