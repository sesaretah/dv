class Involvement < ActiveRecord::Base

  validates :publisher, presence: true
  validates :article, presence: true

  belongs_to :publisher
  belongs_to :article
end
