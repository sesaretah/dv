class AddAlterContentTemplatesToAccessControl < ActiveRecord::Migration
  def change
    add_column :access_controls, :alter_content_templates, :integer
  end
end
