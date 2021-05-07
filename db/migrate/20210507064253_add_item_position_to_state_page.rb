class AddItemPositionToStatePage < ActiveRecord::Migration
  def change
    add_column :state_pages, :item_position, :boolean
  end
end
