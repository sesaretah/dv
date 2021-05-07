class AddCommentTypeToComments < ActiveRecord::Migration
  def change
    add_column :comments, :comment_type, :string
    add_index :comments, :comment_type
  end
end
