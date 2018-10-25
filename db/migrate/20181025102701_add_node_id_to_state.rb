class AddNodeIdToState < ActiveRecord::Migration
  def change
    add_column :workflow_states, :node_id, :integer
  end
end
