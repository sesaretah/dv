class AddArticleIdToWorkflowTransition < ActiveRecord::Migration
  def change
    add_column :workflow_transitions, :article_id, :integer
  end
end
