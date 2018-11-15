class Vote < ActiveRecord::Base
  belongs_to :user
  belongs_to :voting
  belongs_to :article
end
