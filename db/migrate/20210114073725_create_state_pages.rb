class CreateStatePages < ActiveRecord::Migration
  def change
    create_table :state_pages do |t|
      t.integer :workflow_state_id
      t.boolean :item_title
      t.boolean :item_titlings
      t.boolean :item_abstract
      t.boolean :item_url
      t.boolean :item_keywords
      t.boolean :item_datings
      t.boolean :item_typings
      t.boolean :item_speakings
      t.boolean :item_formatings
      t.boolean :item_contributions
      t.boolean :item_kinships
      t.boolean :item_originatings
      t.boolean :item_content
      t.boolean :item_upload

      t.timestamps null: false
    end
  end
end
