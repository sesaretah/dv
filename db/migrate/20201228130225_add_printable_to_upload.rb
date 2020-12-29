class AddPrintableToUpload < ActiveRecord::Migration
  def change
    add_column :uploads, :printable, :boolean
  end
end
