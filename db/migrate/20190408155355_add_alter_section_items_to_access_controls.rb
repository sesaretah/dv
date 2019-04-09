class AddAlterSectionItemsToAccessControls < ActiveRecord::Migration
  def change
    add_column :access_controls, :alter_section_items, :integer
  end
end
