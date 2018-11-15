class AddContentTemplateIdToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :content_template_id, :integer
  end
end
