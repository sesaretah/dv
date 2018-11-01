class AddUserIdToArticleFormat < ActiveRecord::Migration
  def change
    add_column :article_formats, :user_id, :integer
  end
end
