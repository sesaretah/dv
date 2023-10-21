class Kinship < ActiveRecord::Base
  validates :kin, presence: true
  validates :article_relation_type, presence: true

  belongs_to :article
  belongs_to :kin, :class_name => "Article"
  belongs_to :article_relation_type

  after_save :create_reverse

  after_destroy :destroy_reverse 

  def create_reverse
    if !article_relation_type.reverse_relation_id.blank?
      reverse_kinship = Kinship.where(kin_id: article_id, article_id: kin.id, article_relation_type_id: article_relation_type.reverse_relation_id).first
      if !reverse_kinship.present?
        Kinship.create(kin_id: article_id, article_id: kin.id, article_relation_type_id: article_relation_type.reverse_relation_id)
      end
    end
  end

  def destroy_reverse
    reverse_kinship = Kinship.where(kin_id: article_id, article_id: kin.id, article_relation_type_id: article_relation_type.reverse_relation_id).first
    if reverse_kinship.present?
      reverse_kinship.destroy
    end
  end 

end
