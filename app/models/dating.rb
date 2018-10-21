class Dating < ActiveRecord::Base
  belongs_to :article_event
  belongs_to :article
end
