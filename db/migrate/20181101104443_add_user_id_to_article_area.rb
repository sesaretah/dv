class AddUserIdToArticleArea < ActiveRecord::Migration
  def change
    add_column :article_areas, :user_id, :integer
  end
end
