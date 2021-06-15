class AddNotifiableToWorkflowStates < ActiveRecord::Migration
  def change
    add_column :workflow_states, :notifiable, :integer
    add_index :workflow_states, :notifiable
  end
end
