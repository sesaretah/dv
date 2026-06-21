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

  # Generates the same article_received / article_sent notifications that the
  # manual send_to flow creates, so transitions made outside the controller
  # (e.g. the automatic Carrier advance for votable states) also notify users.
  # Each user is isolated so one bad record can't abort the whole batch.
  def notify_recipients(emmiter_id: nil)
    emmiter = emmiter_id || self.user_id
    notify_role(WorkflowState.find_by_id(self.to_state_id), 'article_received', emmiter)
    notify_role(WorkflowState.find_by_id(self.from_state_id), 'article_sent', emmiter)
  end

  private

  def notify_role(state, notification_type, emmiter_id)
    return if state.blank? || state.role.blank?
    state.role.users.each do |user|
      next if user.blank?
      begin
        Notification.create(user_id: user.id, notifiable_type: 'WorkflowTransition',
                            notifiable_id: self.id, notification_type: notification_type,
                            emmiter_id: emmiter_id)
      rescue => e
        Rails.logger.error("WorkflowTransition#notify_recipients failed: transition=#{self.id} user=#{user.id} type=#{notification_type}: #{e.class}: #{e.message}")
      end
    end
  end
end
