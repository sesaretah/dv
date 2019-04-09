class AddKlassNameToSectionItem < ActiveRecord::Migration
  def change
    add_column :section_items, :klass_name, :string
  end
end
