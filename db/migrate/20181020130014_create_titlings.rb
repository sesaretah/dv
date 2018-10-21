class CreateTitlings < ActiveRecord::Migration
  def change
    create_table :titlings do |t|
      t.integer :title_type_id
      t.integer :article_id
      t.integer :status

      t.timestamps null: false
    end
  end
end
