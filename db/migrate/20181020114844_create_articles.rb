class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.text :abstract
      t.text :content
      t.string :url
      t.string :slug

      t.timestamps null: false
    end
  end
end
