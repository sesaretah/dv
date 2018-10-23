class AddAttachmentTypeToUpload < ActiveRecord::Migration
  def change
    add_column :uploads, :attachment_type, :string
  end
end
