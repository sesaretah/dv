class AddNotesToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :notes, :text
  end
end
