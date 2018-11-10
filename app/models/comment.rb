class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :commentable, :polymorphic => true
  belongs_to :article, :class_name => "Article", :foreign_key => "commentable_id"
end
