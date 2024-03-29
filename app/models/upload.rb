class Upload < ActiveRecord::Base
  has_attached_file :attachment, :styles => { :medium => "140x140>", :tiny => "20x20>" ,:thumb => "50x50>", :large => "600x600>"  }, :original => ["100%", :jpg], :default_url => "/assets/noimage-35-:style.jpg"
  validates_attachment_content_type :attachment, :content_type => ["image/jpg", "image/jpeg", "image/png", 'image/tiff', "image/gif", "application/pdf","application/vnd.ms-excel",
    "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
    "application/msword",
    "application/vnd.openxmlformats-officedocument.presentationml.presentation",
    "application/vnd.openxmlformats-officedocument.wordprocessingml.document",
    "text/plain", "audio/webm", "video/webm"]
  before_post_process :rename_avatar
  before_post_process :resize_images
  belongs_to :uploadable, :polymorphic => true
  belongs_to :article, :class_name => "Article", :foreign_key => "uploadable_id"
  def rename_avatar
    if !self.attachment.blank?
      extension = File.extname(attachment_file_name).downcase
      self.attachment.instance_write :file_name, "#{Time.now.to_i.to_s}#{extension}"
    end
  end
  def image?
    attachment_content_type =~ %r{^(image|(x-)?application)/(bmp|gif|jpeg|jpg|pjpeg|png|x-png|tif|tiff)$}
  end

  private

  def resize_images
    return false unless image?
  end

  def extract_text
    if self.uploadable_type = 'Article'
      @article = Article.find_by_id(self.uploadable_id)
      if !@article.blank?
        @article.document_contents = ''
        for upload in @article.uploads
          @text =  %x[java -jar #{Rails.root}/lib/tika-app-1.20.jar -h #{upload.attachment.path}]
          if !@text.blank?
            @article.document_contents =  @article.document_contents + ' ' + @text
          end
        end
        @article.save
      end
    end
  end

end
