class AddProfileIdToContribution < ActiveRecord::Migration
  def change
    add_column :contributions, :profile_id, :integer
  end
end
