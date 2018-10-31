class CreateAreaingHistories < ActiveRecord::Migration
  def change
    create_table :areaing_histories do |t|
      t.integer :article_id
      t.integer :article_area_id
      t.string :revision_number
      t.integer :user_id
      t.integer :workflow_transition_id
      t.integer :areaing_id

      t.timestamps null: false
    end
  end
end
