class AddKinshipIdToKinshipHistory < ActiveRecord::Migration
  def change
    add_column :kinship_histories, :kinship_id, :integer
  end
end
