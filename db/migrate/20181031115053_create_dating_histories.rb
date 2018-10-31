class CreateDatingHistories < ActiveRecord::Migration
  def change
    create_table :dating_histories do |t|
      t.integer :article_id
      t.integer :article_event_id
      t.date :event_date
      t.string :revision_number
      t.integer :user_id
      t.integer :workflow_transition_id

      t.timestamps null: false
    end
  end
end
