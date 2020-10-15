class CreateWorkflowRoleAccesses < ActiveRecord::Migration
  def change
    create_table :workflow_role_accesses do |t|
      t.integer :workflow_id
      t.integer :role_id
      t.boolean :own_article_traceable
      t.boolean :other_articles_traceable

      t.timestamps null: false
    end
    add_index :workflow_role_accesses, :workflow_id
    add_index :workflow_role_accesses, :role_id
  end
end
