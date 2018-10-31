class AddDatingIdToDatingHistory < ActiveRecord::Migration
  def change
    add_column :dating_histories, :dating_id, :integer
  end
end
