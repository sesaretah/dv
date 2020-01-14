class AddStratPointToRole < ActiveRecord::Migration
  def change
    add_column :roles, :start_point, :boolean
  end
end
