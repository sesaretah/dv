class AddUserIdToTitleType < ActiveRecord::Migration
  def change
    add_column :title_types, :user_id, :integer
  end
end
