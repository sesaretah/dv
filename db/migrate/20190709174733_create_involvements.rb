class CreateInvolvements < ActiveRecord::Migration
  def change
    create_table :involvements do |t|
      t.integer :article_id
      t.integer :publisher_id
      t.text :details

      t.timestamps null: false
    end
  end
end
