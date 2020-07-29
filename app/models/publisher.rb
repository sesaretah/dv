class Publisher < ActiveRecord::Base
  after_save ThinkingSphinx::RealTime.callback_for(:publisher)
  has_many :articles, :through => :publications
  has_many :publications, dependent: :destroy
  has_many :publish_sources, dependent: :destroy

  belongs_to :user
end
