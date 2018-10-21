class ArticleType < ActiveRecord::Base
  has_many :articles, :through => :typings
  has_many :typings, dependent: :destroy
end
