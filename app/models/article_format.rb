class ArticleFormat < ActiveRecord::Base
  after_save ThinkingSphinx::RealTime.callback_for(:article_format)
  has_many :articles, :through => :formatings
  has_many :formatings, dependent: :destroy
  belongs_to :user

  def self.merge_article_format(article_format_1, article_format_2)
    @formatings = article_format_2.formatings
    for formating in @formatings
      formating.article_format_id = article_format_1.id
      formating.save
    end
  end
end
