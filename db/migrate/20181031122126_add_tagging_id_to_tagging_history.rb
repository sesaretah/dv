class AddTaggingIdToTaggingHistory < ActiveRecord::Migration
  def change
    add_column :tagging_histories, :tagging_id, :integer
  end
end
