class AddUserIdToWordTemplate < ActiveRecord::Migration
  def change
    add_column :word_templates, :user_id, :integer
  end
end
