class CreateArticleSources < ActiveRecord::Migration
  def change
    create_table :article_sources do |t|
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
