class Duty < ActiveRecord::Base
  after_save ThinkingSphinx::RealTime.callback_for(:duty)
  has_many :articles, :through => :contributions
  has_many :contributions, dependent: :destroy
  belongs_to :user
end
