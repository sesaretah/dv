class AddItemPublicationsToStatePage < ActiveRecord::Migration
  def change
    add_column :state_pages, :item_publications, :boolean
  end
end
