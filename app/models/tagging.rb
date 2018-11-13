class Tagging < ActiveRecord::Base
  belongs_to :taggable, :polymorphic => true
  belongs_to :article, :class_name => "Article", :foreign_key => "taggable_id"
end
