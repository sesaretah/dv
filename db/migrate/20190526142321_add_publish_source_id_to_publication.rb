class AddPublishSourceIdToPublication < ActiveRecord::Migration
  def change
    add_column :publications, :publish_source_id, :integer
  end
end
