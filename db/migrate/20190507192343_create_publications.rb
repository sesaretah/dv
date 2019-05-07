class CreatePublications < ActiveRecord::Migration
  def change
    create_table :publications do |t|
      t.integer :article_id
      t.integer :publisher_id
      t.date :publication_date
      t.string :pp
      t.string :vol

      t.timestamps null: false
    end
  end
end
