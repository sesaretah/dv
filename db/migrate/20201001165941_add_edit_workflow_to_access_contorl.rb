class AddEditWorkflowToAccessContorl < ActiveRecord::Migration
  def change
    add_column :access_contorls, :edit_workflow, :integer
  end
end
