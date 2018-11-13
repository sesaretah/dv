class WorkflowState < ActiveRecord::Base
  has_many :articles
  belongs_to :workflow
  belongs_to :role
end
