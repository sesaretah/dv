class PublishSource < ActiveRecord::Base
  belongs_to :publisher
  belongs_to :user
  has_many :publications
end
