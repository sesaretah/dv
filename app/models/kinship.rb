class Kinship < ActiveRecord::Base
  validates :kin, presence: true
  validates :article_relation_type, presence: true

  belongs_to :article
  belongs_to :kin, :class_name => "Article"
  belongs_to :article_relation_type
end
