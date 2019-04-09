class AddToSectionItems < ActiveRecord::Migration
  def change
    add_column :section_items, :title, :string
    add_column :section_items, :description, :string
    add_column :section_items, :user_id, :integer
  end
end
