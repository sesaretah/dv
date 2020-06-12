class AddSurenameToUser < ActiveRecord::Migration
  def change
    add_column :users, :surename, :string
  end
end
