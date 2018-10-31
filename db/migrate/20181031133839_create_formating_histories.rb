class CreateFormatingHistories < ActiveRecord::Migration
  def change
    create_table :formating_histories do |t|
      t.integer :article_format_id
      t.integer :article_id
      t.integer :user_id
      t.string :revision_number
      t.integer :workflow_state_id
      t.integer :formating_id

      t.timestamps null: false
    end
  end
end
