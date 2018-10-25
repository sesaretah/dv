class Profile < ActiveRecord::Base
  after_save ThinkingSphinx::RealTime.callback_for(:profile)
  has_many :articles, :through => :contributions
  has_many :contributions, dependent: :destroy
  def fullname
    "#{self.name} #{self.surename}"
  end
  def title
    "#{self.name} #{self.surename}"
  end
end
