class AddAccessGroupIdToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :access_group_id, :integer
  end
end
