class Speaking < ActiveRecord::Base
  belongs_to :langauge
  belongs_to :article
end
