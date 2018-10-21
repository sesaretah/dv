class CreateTypings < ActiveRecord::Migration
  def change
    create_table :typings do |t|
      t.integer :article_type_id
      t.integer :article_id

      t.timestamps null: false
    end
  end
end
