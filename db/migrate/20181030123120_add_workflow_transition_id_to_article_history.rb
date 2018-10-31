class AddWorkflowTransitionIdToArticleHistory < ActiveRecord::Migration
  def change
    add_column :article_histories, :workflow_transition_id, :integer
  end
end
