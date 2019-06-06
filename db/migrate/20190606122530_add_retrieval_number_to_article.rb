class AddRetrievalNumberToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :retrieval_number, :string
  end
end
