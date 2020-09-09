class ArticleArea < ActiveRecord::Base
    after_save ThinkingSphinx::RealTime.callback_for(:article_area)
    has_many :articles, :through => :areaings
    has_many :areaings, dependent: :destroy
    belongs_to :user


  def self.merge_article_area(article_area_1, article_area_2)
    @areaings = article_area_2.areaings
    for areaing in @areaings
        areaing.article_area_id = article_area_1.id
        areaing.save
    end
  end
end
