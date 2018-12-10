class AddDocumentContentsToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :document_contents, :text
  end
end
