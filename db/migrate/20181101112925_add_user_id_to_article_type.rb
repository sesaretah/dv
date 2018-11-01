class AddUserIdToArticleType < ActiveRecord::Migration
  def change
    add_column :article_types, :user_id, :integer
  end
end
