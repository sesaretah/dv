class AddTrialsToCarrier < ActiveRecord::Migration
  def change
    add_column :carriers, :trials, :integer
  end
end
