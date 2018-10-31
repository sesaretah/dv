class AddAttachmentAttachmentToUploadHistories < ActiveRecord::Migration
  def self.up
    change_table :upload_histories do |t|
      t.attachment :attachment
    end
  end

  def self.down
    remove_attachment :upload_histories, :attachment
  end
end
