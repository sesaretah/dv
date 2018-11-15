class WorkflowState < ActiveRecord::Base
  has_many :articles
  belongs_to :workflow
  belongs_to :role
  after_save :set_voting

  has_many :votings, :as => :votable, :dependent => :destroy

  def set_voting
    if self.votable == 2
      @voting = Voting.where(votable_type: 'WorkflowState', votable_id: self.id)
      if @voting.blank?
        Voting.create(votable_type: 'WorkflowState', votable_id: self.id)
      end
    end
  end
end
