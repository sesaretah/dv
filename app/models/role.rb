class Role < ActiveRecord::Base
  after_save ThinkingSphinx::RealTime.callback_for(:role)

  has_many :articles, :through => :contributions
  has_many :contributions, dependent: :destroy

  has_many :users, :through => :assignments
  has_many :assignments, dependent: :destroy
  belongs_to :user
  has_one :access_control, dependent: :destroy

  has_many :access_groups, :through => :role_accesses
  has_many :role_accesses, dependent: :destroy

  has_many :workflow_states

  after_create :set_access_control

  def set_access_control
    AccessControl.create(role_id: self.id)
  end

  def self.merge_role(role_1, role_2)
    @contributions = role_2.contributions
    for contribution in @contributions
      contribution.role_id = role_1.id
      contribution.save
    end

    @assignments = role_2.assignments
    for assignment in @assignments
      assignment.role_id = role_1.id
      assignment.save
    end

    @role_accesses = role_2.role_accesses
    for role_access in @role_accesses
      role_access.role_id = role_1.id
      role_access.save
    end

    @workflow_states = role_2.workflow_states
    for workflow_state in @workflow_states
      workflow_state.role_id = role_1.id
      workflow_state.save
    end

    for user in User.all
      if user.current_role_id == role_2.id
        user.current_role_id == role_1.id
        user.save
      end
    end

    for workflow in Workflow.all
      trimed_nodes = []
      nodes = JSON.parse workflow.nodes
      for node in nodes
        if node['role'] == role_2.id
          node['role'] = role_1.id
        end
        trimed_nodes << node
      end
      workflow.nodes = trimed_nodes.to_json
      workflow.save
    end
    
  end

end
