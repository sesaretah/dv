class AddContentToTitling < ActiveRecord::Migration
  def change
    add_column :titlings, :content, :string
  end
end
