class AddItemNotesToStatePage < ActiveRecord::Migration
  def change
    add_column :state_pages, :item_notes, :boolean
  end
end
