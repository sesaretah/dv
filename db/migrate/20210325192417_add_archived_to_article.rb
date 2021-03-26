class AddArchivedToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :archived, :boolean
  end
end
