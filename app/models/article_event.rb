class ArticleEvent < ActiveRecord::Base
  has_many :articles, :through => :datings
  has_many :datings, dependent: :destroy
  belongs_to :user
end
