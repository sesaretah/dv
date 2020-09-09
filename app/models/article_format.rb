class ArticleFormat < ActiveRecord::Base
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
