class CreateFormatings < ActiveRecord::Migration
  def change
    create_table :formatings do |t|
      t.integer :article_format_id
      t.integer :article_id

      t.timestamps null: false
    end
  end
end
