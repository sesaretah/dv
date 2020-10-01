class AddEditWorkflowToAccessContorl < ActiveRecord::Migration
  def change
    add_column :access_controls, :edit_workflow, :integer
  end
end
