class AddEditableToWorkflowState < ActiveRecord::Migration
  def change
    add_column :workflow_states, :editable, :text
    add_column :workflow_states, :refundable, :integer
    add_column :workflow_states, :commentable, :integer
    add_column :workflow_states, :start_point, :integer
    add_column :workflow_states, :end_point, :integer
  end
end
