class AddWorkflowStateIdToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :workflow_state_id, :integer
  end
end
