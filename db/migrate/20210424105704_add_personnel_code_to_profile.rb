class AddPersonnelCodeToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :personnel_code, :integer
  end
end
