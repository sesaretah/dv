class AddUserIdToArticleHistory < ActiveRecord::Migration
  def change
    add_column :article_histories, :user_id, :integer
  end
end
