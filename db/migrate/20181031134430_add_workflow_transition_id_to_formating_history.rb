class AddWorkflowTransitionIdToFormatingHistory < ActiveRecord::Migration
  def change
    add_column :formating_histories, :workflow_transition_id, :integer
  end
end
