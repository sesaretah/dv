class PublishSource < ActiveRecord::Base
  belongs_to :publisher
  belongs_to :user
end
