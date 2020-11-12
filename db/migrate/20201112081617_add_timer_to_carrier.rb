class AddTimerToCarrier < ActiveRecord::Migration
  def change
    add_column :carriers, :timer, :integer
  end
end
