class AddVotingConditionToCarrier < ActiveRecord::Migration
  def change
    add_column :carriers, :voting_condition, :integer
  end
end
