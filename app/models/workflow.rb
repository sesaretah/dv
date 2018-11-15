class Workflow < ActiveRecord::Base
  has_many :workflow_states
  has_many :articles, :through => :workflow_states
  has_many :workflow_states, dependent: :destroy
  belongs_to :user

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

  def previous_nodes(current_node_id)
    @nodes = JSON.parse self.nodes
    @edges = JSON.parse self.edges
    @previouses = []
    for edge in @edges
      if edge['target']['id'] == current_node_id
        @previouses << edge['source']['id']
      end
    end
    return WorkflowState.where(workflow_id: self.id, node_id: @previouses)
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

  def prepare_edges
    @nodes = JSON.parse self.nodes
    @edges = JSON.parse self.edges
    @result = []
    for edge in @edges
      @source =  find_node_index(@nodes, edge['source']['id'])
      @target =  find_node_index(@nodes, edge['target']['id'])
      @result <<  { 'source' => "nodes[#{@source}]", 'target' => "nodes[#{@target}]"}
    end
    return @result
  end

  def end_states
    @result = []
    for workflow_state in self.workflow_states
      if workflow_state.end_point == 2
        @result << workflow_state.id
      end
    end
    return @result
  end

  def not_end_states
    @result = []
    for workflow_state in self.workflow_states
      if workflow_state.end_point != 2
        @result << workflow_state.id
      end
    end
    return @result
  end

  def find_node_index(nodes, node_id)
    for node in nodes
      if node['id'] == node_id
        return nodes.index(node)
      end
    end
  end

end
