class AddRoleIdToWorkflowState < ActiveRecord::Migration
  def change
    add_column :workflow_states, :role_id, :integer
  end
end
