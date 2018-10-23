class Originating < ActiveRecord::Base
  belongs_to :article_source
  belongs_to :article
end
