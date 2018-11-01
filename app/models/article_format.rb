class ArticleFormat < ActiveRecord::Base
  has_many :articles, :through => :formatings
  has_many :formatings, dependent: :destroy
  belongs_to :user
end
