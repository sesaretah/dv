class AddAttachmentSignatureToProfiles < ActiveRecord::Migration
  def self.up
    change_table :profiles do |t|
      t.attachment :signature
    end
  end

  def self.down
    remove_attachment :profiles, :signature
  end
end
