class CreateArticleHistories < ActiveRecord::Migration
  def change
    create_table :article_histories do |t|
      t.string :title
      t.text :abstract
      t.text :content
      t.string :url
      t.text :document_contents

      t.timestamps null: false
    end
  end
end
