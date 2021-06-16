class WorkflowTransition < ActiveRecord::Base
  belongs_to :user
  belongs_to :article
  after_save :check_mirorr

  def check_mirorr
    mirorr = Mirorr.where(source_state: self.to_state_id).first
    if !mirorr.blank?
      self.article.make_a_copy(mirorr.target_state, self.user)
    end
  end

  def from_state
    workflow_state = WorkflowState.find(self.from_state_id) if !self.from_state_id.blank?
    return workflow_state if !workflow_state.blank?
  end

  def to_state
    workflow_state = WorkflowState.find_by_id(self.to_state_id) if !self.to_state_id.blank?
    return workflow_state if !workflow_state.blank?
  end
end
