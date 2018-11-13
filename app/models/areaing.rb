class Areaing < ActiveRecord::Base
  validates :article_area, presence: true
  validates :article, presence: true

  belongs_to :article
  belongs_to :article_area
end
