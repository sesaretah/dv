class AddAttachmentAttachmentToUploads < ActiveRecord::Migration
  def self.up
    change_table :uploads do |t|
      t.attachment :attachment
    end
  end

  def self.down
    remove_attachment :uploads, :attachment
  end
end
