class WorkflowState < ActiveRecord::Base
  has_many :articles
  belongs_to :workflow
  belongs_to :role
  after_save :set_voting

  has_many :votings, :as => :votable, :dependent => :destroy

  def self.user_start_workflow_states(user)
    role_ids = user.roles.pluck(:id)
    workflow_states = WorkflowState.where("role_id in (?) and start_point = 2", role_ids).order(:title)
    return workflow_states
  end

  def set_voting
    if self.votable == 2
      @voting = Voting.where(votable_type: "WorkflowState", votable_id: self.id)
      if @voting.blank?
        Voting.create(votable_type: "WorkflowState", votable_id: self.id)
      end
    end
  end

  def is_votable
    if self.votable.blank? || self.votable == 01
      return false
    end
    if self.votable == 2
      return true
    end
  end

  def yay_votes
    voting = self.votes
    Vote.where("voting_id = ? and outcome in (?)", voting.id, [0, 1]).count if voting
  end

  def nay_votes
    voting = self.votes
    Vote.where(voting_id: voting.id, outcome: -1).count if voting
  end

  def votes
    Voting.where(votable_type: "WorkflowState", votable_id: self.id).first
  end

  def majority
    return true if !self.is_votable
    if self.yay_votes > self.nay_votes
      return true
    else
      return false
    end
  end

  def consensus
    if self.nay_votes >= 1
      return false
    else
      return true
    end
  end
end
