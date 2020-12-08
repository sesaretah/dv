class AddPublishUuidToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :publish_uuid, :string
    add_index :articles, :publish_uuid
  end
end
