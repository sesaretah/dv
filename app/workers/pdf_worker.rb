class PdfWorker
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform(id, uuid, type='raw_print')
       article = Article.find_by_id(id)
       article.pdf_generated = false
       article.save
       if !article.blank?
         system("mkdir #{Rails.root}/public/pdfs/#{id}")
         system("wkhtmltopdf --page-size Letter --viewport-size 1280x1024  --margin-bottom 25mm #{Rails.application.routes.default_url_options[:host]}/articles/#{type}/#{id} #{Rails.root}/public/pdfs/#{id}/#{uuid}.pdf")
         for upload in Upload.where("uploadable_type = ? AND uploadable_id =  ? AND attachment_type IN  (?) AND printable is true", 'Article', id, ['article_citation', 'article_attachment', 'article_documents'])
           if upload.attachment_content_type == 'application/pdf'
             system("convert -density 150 #{Rails.root}/public/pdfs/#{id}/#{uuid}.pdf #{Rails.root}/public/pdfs/#{id}/#{upload.id}.pdf #{Rails.root}/public/pdfs/#{id}/#{uuid}.pdf")
           end
         end
         article.pdf_generated = true
         article.save
       end
    end
  end
