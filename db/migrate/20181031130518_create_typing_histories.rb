class CreateTypingHistories < ActiveRecord::Migration
  def change
    create_table :typing_histories do |t|
      t.integer :article_type_id
      t.integer :article_id
      t.integer :typing_id
      t.string :revision_number
      t.integer :user_id
      t.integer :workflow_transition_id

      t.timestamps null: false
    end
  end
end
