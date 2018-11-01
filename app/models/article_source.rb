class ArticleSource < ActiveRecord::Base
  after_save ThinkingSphinx::RealTime.callback_for(:article_source)
  has_many :articles, :through => :originatings
  has_many :originatings, dependent: :destroy
  belongs_to :user
end
