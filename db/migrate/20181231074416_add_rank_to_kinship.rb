class AddRankToKinship < ActiveRecord::Migration
  def change
    add_column :kinships, :rank, :integer, :default => 0
  end
end
