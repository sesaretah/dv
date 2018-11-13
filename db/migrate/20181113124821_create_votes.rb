class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :voting_id
      t.integer :outcome

      t.timestamps null: false
    end
  end
end
