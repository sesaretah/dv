class Speaking < ActiveRecord::Base
  belongs_to :language
  belongs_to :article
end
