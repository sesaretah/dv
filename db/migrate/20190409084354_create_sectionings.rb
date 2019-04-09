class CreateSectionings < ActiveRecord::Migration
  def change
    create_table :sectionings do |t|
      t.integer :section_id
      t.integer :section_item_id

      t.timestamps null: false
    end
  end
end
