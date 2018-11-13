class CreateVotings < ActiveRecord::Migration
  def change
    create_table :votings do |t|
      t.integer :votable_id
      t.string :votable_type
      t.integer :deadline
      t.integer :voting_type

      t.timestamps null: false
    end
  end
end
