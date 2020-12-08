class AddPublishedViaToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :published_via, :integer
  end
end
