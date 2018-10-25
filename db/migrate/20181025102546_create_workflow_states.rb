class CreateWorkflowStates < ActiveRecord::Migration
  def change
    create_table :workflow_states do |t|
      t.string :title
      t.integer :workflow_id

      t.timestamps null: false
    end
  end
end
