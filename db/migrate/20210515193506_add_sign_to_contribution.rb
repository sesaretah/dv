class AddSignToContribution < ActiveRecord::Migration
  def change
    add_column :contributions, :sign, :boolean
  end
end
