class AddItemRetrievalNumberToStatePage < ActiveRecord::Migration
  def change
    add_column :state_pages, :item_retrieval_number, :boolean
  end
end
