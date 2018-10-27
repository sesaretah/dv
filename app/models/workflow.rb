class Workflow < ActiveRecord::Base
  has_many :workflow_states
end
