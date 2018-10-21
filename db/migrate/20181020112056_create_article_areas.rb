class CreateArticleAreas < ActiveRecord::Migration
  def change
    create_table :article_areas do |t|
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
