class PdfWorker
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform(id)
       article = Article.find_by_id(id)
       if !article.blank?
         system("mkdir #{Rails.root}/public/pdfs/#{id}")
         system("wkhtmltopdf #{Rails.application.routes.default_url_options[:host]}/articles/raw_print/#{id} #{Rails.root}/public/pdfs/#{id}/#{id}.pdf")
         for upload in Upload.where("uploadable_type = ? AND uploadable_id =  ? AND attachment_type IN  (?)", 'Article', id, ['article_citation', 'article_attachment', 'article_documents'])
           if upload.attachment_content_type == 'application/pdf'
             system("convert -density 150 #{Rails.root}/public/pdfs/#{id}/#{id}.pdf #{upload.attachment.path} #{Rails.root}/public/pdfs/#{id}/#{id}.pdf")
           end
         end
       end
    end
  end
