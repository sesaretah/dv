class Typing < ActiveRecord::Base
  belongs_to :article
  belongs_to :article_type
end
