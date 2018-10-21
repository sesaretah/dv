class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.string :title
      t.text :description

      t.timestamps null: false
    end
  end
end
