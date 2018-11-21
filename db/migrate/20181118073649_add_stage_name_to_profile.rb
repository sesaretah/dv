class AddStageNameToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :stage_name, :string
  end
end
