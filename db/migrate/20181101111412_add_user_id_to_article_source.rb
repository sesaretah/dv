class AddUserIdToArticleSource < ActiveRecord::Migration
  def change
    add_column :article_sources, :user_id, :integer
  end
end
