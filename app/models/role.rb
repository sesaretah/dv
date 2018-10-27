class Role < ActiveRecord::Base
  after_save ThinkingSphinx::RealTime.callback_for(:role)

  has_many :articles, :through => :contributions
  has_many :contributions, dependent: :destroy

  has_many :users, :through => :assignments
  has_many :assignments, dependent: :destroy
end
