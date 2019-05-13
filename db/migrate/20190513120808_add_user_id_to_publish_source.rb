class AddUserIdToPublishSource < ActiveRecord::Migration
  def change
    add_column :publish_sources, :user_id, :integer
  end
end
