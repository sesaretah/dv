class Publication < ActiveRecord::Base
  belongs_to :publisher
  belongs_to :article
end
