class AddRevisionNumberToWorkflowTransition < ActiveRecord::Migration
  def change
    add_column :workflow_transitions, :revision_number, :string
  end
end
