class CreateSpeakings < ActiveRecord::Migration
  def change
    create_table :speakings do |t|
      t.integer :language_id
      t.integer :article_id

      t.timestamps null: false
    end
  end
end
