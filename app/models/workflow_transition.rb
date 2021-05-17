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
end
