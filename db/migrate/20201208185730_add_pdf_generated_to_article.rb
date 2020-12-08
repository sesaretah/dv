class AddPdfGeneratedToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :pdf_generated, :boolean
  end
end
