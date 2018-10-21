class CreateArticleFormats < ActiveRecord::Migration
  def change
    create_table :article_formats do |t|
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
