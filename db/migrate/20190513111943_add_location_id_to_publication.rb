class AddLocationIdToPublication < ActiveRecord::Migration
  def change
    add_column :publications, :location_id, :integer
  end
end
