class AddDetailToUpload < ActiveRecord::Migration
  def change
    add_column :uploads, :detail, :text
  end
end
