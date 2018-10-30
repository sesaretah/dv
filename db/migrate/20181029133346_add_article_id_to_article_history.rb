class AddArticleIdToArticleHistory < ActiveRecord::Migration
  def change
    add_column :article_histories, :article_id, :integer
  end
end
