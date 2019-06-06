class AddDimensionsToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :dimensions, :string
  end
end
