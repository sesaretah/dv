class AddExternalIdToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :external_id, :integer
  end
end
