class CreateOriginatings < ActiveRecord::Migration
  def change
    create_table :originatings do |t|
      t.integer :article_id
      t.integer :article_source_id

      t.timestamps null: false
    end
  end
end
