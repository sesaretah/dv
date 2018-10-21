class CreateArticleEvents < ActiveRecord::Migration
  def change
    create_table :article_events do |t|
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
