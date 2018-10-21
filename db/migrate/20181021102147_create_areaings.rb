class CreateAreaings < ActiveRecord::Migration
  def change
    create_table :areaings do |t|
      t.integer :article_area_id
      t.integer :article_id

      t.timestamps null: false
    end
  end
end
