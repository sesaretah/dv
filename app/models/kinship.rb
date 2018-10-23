class Kinship < ActiveRecord::Base
  belongs_to :article
  belongs_to :kin, :class_name => "Article"
  belongs_to :article_relation_type
end
