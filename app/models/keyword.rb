class Keyword < ActiveRecord::Base
  after_save ThinkingSphinx::RealTime.callback_for(:keyword)
  belongs_to :user
end
