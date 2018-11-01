class AddUserIdToArticleRelationType < ActiveRecord::Migration
  def change
    add_column :article_relation_types, :user_id, :integer
  end
end
