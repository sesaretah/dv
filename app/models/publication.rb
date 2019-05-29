class Publication < ActiveRecord::Base
  belongs_to :publisher
  belongs_to :article
  belongs_to :location
  belongs_to :publish_source
end
