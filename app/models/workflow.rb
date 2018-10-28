class Workflow < ActiveRecord::Base
  has_many :workflow_states

  def next_nodes(current_node_id)
    @nodes = JSON.parse self.nodes
    @edges = JSON.parse self.edges
    @nexts = []
    for edge in @edges
      if edge['source']['id'] == current_node_id
        @nexts << edge['target']['id']
      end
    end
    return WorkflowState.where(workflow_id: self.id, node_id: @nexts)
  end

  def is_next_node(current_node_id, next_node_id)
    @nodes = JSON.parse self.nodes
    @edges = JSON.parse self.edges
    @nexts = []
    for edge in @edges
      if edge['source']['id'] == current_node_id
        @nexts << edge['target']['id']
      end
    end
    if @nexts.include?(next_node_id)
      return true
    else
      return false
    end
  end

  def is_previous_node(current_node_id, previous_node_id)
    @nodes = JSON.parse self.nodes
    @edges = JSON.parse self.edges
    @nexts = []
    for edge in @edges
      if edge['target']['id'] == current_node_id
        @nexts << edge['source']['id']
      end
    end
    if @nexts.include?(previous_node_id)
      return true
    else
      return false
    end
  end

end
