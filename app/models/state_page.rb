class StatePage < ActiveRecord::Base
  belongs_to :workflow_state
  before_create :set_uuid

  def set_uuid
    self.uuid = SecureRandom.hex(4)
  end
end
