class CreatePublishSources < ActiveRecord::Migration
  def change
    create_table :publish_sources do |t|
      t.string :title
      t.text :description
      t.integer :publisher_id

      t.timestamps null: false
    end
  end
end
