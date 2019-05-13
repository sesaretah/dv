class Publication < ActiveRecord::Base
  belongs_to :publisher
  belongs_to :article
  belongs_to :location
end
