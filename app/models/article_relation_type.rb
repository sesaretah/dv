class ArticleRelationType < ActiveRecord::Base
  after_save ThinkingSphinx::RealTime.callback_for(:article_relation_type)

  has_many :articles, :through => :kinships
  has_many :kinships, dependent: :destroy
  belongs_to :user

  def self.merge_article_relation_type(article_relation_type_1, article_relation_type_2)
    @kinships = article_relation_type_2.kinships
    for kinship in @kinships
      kinship.article_relation_type_id = article_relation_type_1.id
      kinship.save
    end
  end
end
