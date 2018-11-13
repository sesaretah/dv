class Role < ActiveRecord::Base
  after_save ThinkingSphinx::RealTime.callback_for(:role)

  has_many :articles, :through => :contributions
  has_many :contributions, dependent: :destroy

  has_many :users, :through => :assignments
  has_many :assignments, dependent: :destroy
  belongs_to :user
  has_one :access_control, dependent: :destroy

  has_many :workflow_states

  after_create :set_access_control

  def set_access_control
    AccessControl.create(role_id: self.id)
  end

end
