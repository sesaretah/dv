class AddAccessForOthersToArticles < ActiveRecord::Migration
  def change
    add_column :articles, :access_for_others, :string
  end
end
