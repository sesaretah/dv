class AddVotableToWorkflowState < ActiveRecord::Migration
  def change
    add_column :workflow_states, :votable, :integer
  end
end
