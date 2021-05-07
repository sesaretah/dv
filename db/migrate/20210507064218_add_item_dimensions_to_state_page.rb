class AddItemDimensionsToStatePage < ActiveRecord::Migration
  def change
    add_column :state_pages, :item_dimensions, :boolean
  end
end
