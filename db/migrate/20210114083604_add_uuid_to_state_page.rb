class AddUuidToStatePage < ActiveRecord::Migration
  def change
    add_column :state_pages, :uuid, :string
    add_index :state_pages, :uuid
  end
end
