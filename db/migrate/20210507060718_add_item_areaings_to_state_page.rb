class AddItemAreaingsToStatePage < ActiveRecord::Migration
  def change
    add_column :state_pages, :item_areaings, :boolean
  end
end
