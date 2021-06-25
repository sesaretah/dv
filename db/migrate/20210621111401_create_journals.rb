class CreateJournals < ActiveRecord::Migration
  def change
    create_table :journals do |t|
      t.string :title
      t.string :vol
      t.string :no

      t.timestamps null: false
    end
  end
end
