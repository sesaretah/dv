class AddStatusToSso < ActiveRecord::Migration
  def change
    add_column :ssos, :status, :string
  end
end
