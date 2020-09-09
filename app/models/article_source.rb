class ArticleSource < ActiveRecord::Base
  after_save ThinkingSphinx::RealTime.callback_for(:article_source)
  has_many :articles, :through => :originatings
  has_many :originatings, dependent: :destroy
  belongs_to :user

  def self.merge_article_source(article_source_1, article_source_2)
    @originatings = article_source_2.originatings
    for originating in @originatings
      originating.article_source_id = article_source_1.id
      originating.save
    end
  end
  
end
