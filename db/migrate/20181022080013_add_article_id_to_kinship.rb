class AddArticleIdToKinship < ActiveRecord::Migration
  def change
    add_column :kinships, :article_id, :integer
  end
end
