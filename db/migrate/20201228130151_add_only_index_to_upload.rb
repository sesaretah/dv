class AddOnlyIndexToUpload < ActiveRecord::Migration
  def change
    add_column :uploads, :only_index, :boolean
  end
end
