class AddSummableToUpload < ActiveRecord::Migration
  def change
    add_column :uploads, :summable, :boolean
  end
end
