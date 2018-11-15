class Voting < ActiveRecord::Base
  has_many :votes
  belongs_to :votable, :polymorphic => true
  belongs_to :workflow_state, :class_name => "WorkflowState", :foreign_key => "votable_id"
end
