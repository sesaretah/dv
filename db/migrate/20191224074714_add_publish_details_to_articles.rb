class AddPublishDetailsToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :publish_details, :text
  end
end
