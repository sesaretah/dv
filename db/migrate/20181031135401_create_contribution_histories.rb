class CreateContributionHistories < ActiveRecord::Migration
  def change
    create_table :contribution_histories do |t|
      t.integer :article_id
      t.integer :role_id
      t.integer :duty_id
      t.integer :profile_id
      t.integer :revision_number
      t.integer :user_id
      t.integer :workflow_transition_id
      t.integer :contribution_id

      t.timestamps null: false
    end
  end
end
