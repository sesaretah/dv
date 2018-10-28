class AddStartNodeIdToWorkflow < ActiveRecord::Migration
  def change
    add_column :workflows, :start_node_id, :integer
  end
end
