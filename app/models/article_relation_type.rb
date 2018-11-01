class ArticleRelationType < ActiveRecord::Base
  after_save ThinkingSphinx::RealTime.callback_for(:article_relation_type)

  has_many :articles, :through => :kinships
  has_many :kinships, dependent: :destroy
  belongs_to :user
end
