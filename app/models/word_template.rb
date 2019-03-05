class WordTemplate < ActiveRecord::Base
  has_attached_file :document
  validates_attachment_content_type :document, :content_type => ["application/msword", "application/vnd.openxmlformats-officedocument.wordprocessingml.document"]
  before_post_process :rename_avatar

  belongs_to :user
  belongs_to :workflow

  def rename_avatar
    if !self.document.blank?
      extension = File.extname(document_file_name).downcase
      self.document.instance_write :file_name, "#{Time.now.to_i.to_s}#{extension}"
    end
  end
end
