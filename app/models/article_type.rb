class ArticleType < ActiveRecord::Base
  after_save ThinkingSphinx::RealTime.callback_for(:article_type)
  has_many :articles, :through => :typings
  has_many :typings, dependent: :destroy
  belongs_to :user


  def self.merge_article_type(article_type_1, article_type_2)
    @typings = article_type_2.typings
    for typing in @typings
      typing.article_type_id = article_type_1.id
      typing.save
    end
  end
  
end
