class Assignment < ActiveRecord::Base
  validates :user, presence: true
  validates :role, presence: true

  belongs_to :user
  belongs_to :role

  before_save :check_duplicate
  
  before_destroy :update_home_setting

  def check_duplicate
    assigned = Assignment.where(user_id: self.user_id, role_id: self.role_id).first
    if !assigned.blank?
      false
    else
      true
    end
  end

  def update_home_setting
    begin  
      workflow_state_id = user.home_setting.workflow_state
      workflow_state = WorkflowState.find_by(id: workflow_state_id)
      if workflow_state.role_id == role.id
        user.home_setting.update(workflow_state: -1)
      end
    rescue StandardError
      nil
    end
  end

end
