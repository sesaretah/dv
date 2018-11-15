class AddArticleIdToVote < ActiveRecord::Migration
  def change
    add_column :votes, :article_id, :integer
  end
end
