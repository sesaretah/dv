class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :voting
  belongs_to :article

  def self.is_voted(user, article)
    voting_ids  = Voting.where(votable_id: article.workflow_state.id,  votable_type: "WorkflowState").pluck(:id)
    vote = self.where('voting_id in (?) and article_id = ? and user_id = ?', voting_ids, article.id, user.id).first
    return vote
  end

  def icon
   return "<i class='fe fe-check' style='vertical-align: -3px; color: green;'></i>" if self.outcome == 1
   return "<i class='fe fe-circle' style='vertical-align: -3px;'></i>" if self.outcome == 0
   return "<i class='fe fe-x' style='vertical-align: -3px; color: red;'></i>" if self.outcome == -1
  end
end
