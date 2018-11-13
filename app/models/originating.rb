class Originating < ActiveRecord::Base
  validates :article_source, presence: true
  validates :article, presence: true

  belongs_to :article_source
  belongs_to :article
end
