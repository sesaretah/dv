class CreateDatings < ActiveRecord::Migration
  def change
    create_table :datings do |t|
      t.integer :article_event_id
      t.integer :article_id
      t.date :event_date

      t.timestamps null: false
    end
  end
end
