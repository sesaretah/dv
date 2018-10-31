class CreateOriginatingHistories < ActiveRecord::Migration
  def change
    create_table :originating_histories do |t|
      t.integer :article_id
      t.integer :article_source_id
      t.integer :originating_id
      t.string :revision_number
      t.integer :user_id
      t.integer :workflow_transition_id

      t.timestamps null: false
    end
  end
end
