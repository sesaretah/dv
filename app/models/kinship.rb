class Kinship < ActiveRecord::Base
  validates :kin, presence: true
  validates :article_relation_type, presence: true

  belongs_to :article
  belongs_to :kin, :class_name => "Article"
  belongs_to :article_relation_type

  after_save :create_reverse

  def create_reverse
    if !article_relation_type.reverse_relation_id.blank?
      reverse_kinship = Kinship.where(kin: article_id, reverse_relation_id: article_relation_type.reverse_relation_id).first
      if !reverse_kinship.present?
        Kinship.create(kin: article_id, article_id: kin.id, reverse_relation_id: article_relation_type.reverse_relation_id)
      end
    end
  end
end
