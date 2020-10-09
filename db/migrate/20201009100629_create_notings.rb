class CreateNotings < ActiveRecord::Migration
  def change
    create_table :notings do |t|
      t.integer :note_template_id
      t.integer :article_id
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
