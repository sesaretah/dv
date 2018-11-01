class AddUserIdToArticleEvent < ActiveRecord::Migration
  def change
    add_column :article_events, :user_id, :integer
  end
end
