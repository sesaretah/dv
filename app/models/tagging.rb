class Tagging < ActiveRecord::Base
  belongs_to :taggable, :polymorphic => true
  belongs_to :article, :class_name => "Article", :foreign_key => "taggable_id"

  def title
    @target  = self.target_type.classify.constantize.find_by_id(self.target_id)
    if !@target.blank?
      return @target.title
    else
      return ''
    end
  end
end
