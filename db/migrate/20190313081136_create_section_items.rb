class CreateSectionItems < ActiveRecord::Migration
  def change
    create_table :section_items do |t|
      t.integer :section_id
      t.string :item_name

      t.timestamps null: false
    end
  end
end
