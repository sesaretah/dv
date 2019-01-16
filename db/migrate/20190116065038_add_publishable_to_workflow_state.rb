class AddPublishableToWorkflowState < ActiveRecord::Migration
  def change
    add_column :workflow_states, :publishable, :integer
  end
end
