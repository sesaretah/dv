class AddWorkflowToHomeSetting < ActiveRecord::Migration
  def change
    add_column :home_settings, :workflow, :integer
  end
end
