class AddAbrToRole < ActiveRecord::Migration
  def change
    add_column :roles, :abr, :string
  end
end
