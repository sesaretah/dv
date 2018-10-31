class CreateKinshipHistories < ActiveRecord::Migration
  def change
    create_table :kinship_histories do |t|
      t.integer :user_id
      t.integer :kin_id
      t.integer :article_id
      t.integer :article_relation_type_id
      t.string :revision_number
      t.integer :user_id
      t.integer :workflow_transition_id

      t.timestamps null: false
    end
  end
end
