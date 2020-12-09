class PdfWorker
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform(id, uuid, type='raw_print')
       article = Article.find_by_id(id)
       article.pdf_generated = false
       article.save
       if !article.blank?
         system("mkdir #{Rails.root}/public/pdfs/#{id}")
         system("wkhtmltopdf #{Rails.application.routes.default_url_options[:host]}/articles/#{type}/#{id} #{Rails.root}/public/pdfs/#{id}/#{uuid}.pdf")
         for upload in Upload.where("uploadable_type = ? AND uploadable_id =  ? AND attachment_type IN  (?)", 'Article', id, ['article_citation', 'article_attachment', 'article_documents'])
           if upload.attachment_content_type == 'application/pdf'
             system("convert -density 150 #{Rails.root}/public/pdfs/#{id}/#{uuid}.pdf #{upload.attachment.path} #{Rails.root}/public/pdfs/#{id}/#{uuid}.pdf")
           end
         end
         article.pdf_generated = true
         article.save
       end
    end
  end
