class ArticleEvent < ActiveRecord::Base
  after_save ThinkingSphinx::RealTime.callback_for(:article_event)
  has_many :articles, :through => :datings
  has_many :datings, dependent: :destroy
  belongs_to :user

  def self.merge_article_event(article_event_1, article_event_2)
    @datings = article_event_2.datings
    for dating in @datings
       dating.article_event_id = article_event_1.id
      dating.save
    end
  end
end
