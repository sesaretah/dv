class AddContentWoTagsToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :content_wo_tags, :text
  end
end
