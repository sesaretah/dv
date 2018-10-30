class AddRevisionNumberToArticleHistory < ActiveRecord::Migration
  def change
    add_column :article_histories, :revision_number, :string
  end
end
