class Keyword < ActiveRecord::Base
  after_save ThinkingSphinx::RealTime.callback_for(:keyword)
end
