class CreateTaggingHistories < ActiveRecord::Migration
  def change
    create_table :tagging_histories do |t|
      t.integer :taggable_id
      t.string :taggable_type
      t.integer :target_id
      t.string :target_type
      t.integer :user_id
      t.string :revision_number
      t.integer :article_id
      t.integer :workflow_transition_id

      t.timestamps null: false
    end
  end
end
