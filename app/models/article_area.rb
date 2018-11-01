class ArticleArea < ActiveRecord::Base
    after_save ThinkingSphinx::RealTime.callback_for(:article_area)
    has_many :articles, :through => :areaings
    has_many :areaings, dependent: :destroy
    belongs_to :user
end
