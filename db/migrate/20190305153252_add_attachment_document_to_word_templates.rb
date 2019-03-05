class AddAttachmentDocumentToWordTemplates < ActiveRecord::Migration
  def self.up
    change_table :word_templates do |t|
      t.attachment :document
    end
  end

  def self.down
    remove_attachment :word_templates, :document
  end
end
