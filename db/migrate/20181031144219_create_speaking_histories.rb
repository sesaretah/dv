class CreateSpeakingHistories < ActiveRecord::Migration
  def change
    create_table :speaking_histories do |t|
      t.integer :article_id
      t.integer :language_id
      t.string :revision_number
      t.integer :user_id
      t.integer :workflow_transition_id
      t.integer :speaking_id

      t.timestamps null: false
    end
  end
end
