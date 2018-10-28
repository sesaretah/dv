class CreateWorkflowTransitions < ActiveRecord::Migration
  def change
    create_table :workflow_transitions do |t|
      t.integer :workflow_id
      t.integer :from_state_id
      t.integer :to_state_id
      t.text :message
      t.integer :user_id
      t.integer :role_id
      t.integer :transition_type

      t.timestamps null: false
    end
  end
end
