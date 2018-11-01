class Titling < ActiveRecord::Base
  belongs_to :article
  belongs_to :title_type
end
