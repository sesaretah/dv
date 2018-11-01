class AddUserIdToKeyword < ActiveRecord::Migration
  def change
    add_column :keywords, :user_id, :integer
  end
end
