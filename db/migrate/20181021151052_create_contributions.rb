class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.integer :article_id
      t.integer :role_id
      t.integer :duty_id

      t.timestamps null: false
    end
  end
end
