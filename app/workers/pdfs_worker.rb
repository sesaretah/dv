class PdfsWorker
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform(id, uuid, type='raw_print')
       article = Article.find_by_id(id)
       article.pdf_generated = false
       article.save
       if !article.blank?
         system("mkdir #{Rails.root}/public/pdfs/#{id}")
         system("wkhtmltopdf --page-size Letter --viewport-size 1280x1024  --margin-right 15mm --margin-bottom 20mm #{Rails.application.routes.default_url_options[:host]}/articles/#{type}/#{id} #{Rails.root}/public/pdfs/#{id}/#{uuid}.pdf")
         for upload in Upload.where("uploadable_type = ? AND uploadable_id =  ? AND attachment_type IN  (?) AND printable is true", 'Article', id, ['article_citation', 'article_attachment', 'article_documents'])
           if upload.attachment_content_type == 'application/pdf'
             system("convert -density 150 #{Rails.root}/public/pdfs/#{id}/#{uuid}.pdf #{upload.attachment.path} #{Rails.root}/public/pdfs/#{id}/#{uuid}.pdf")
           end
         end
         for kinship in article.kinships
           uploads = Upload.where("uploadable_type = ? AND uploadable_id =  ? AND attachment_type IN  (?) AND summable is true", 'Article', kinship.kin.id, ['article_citation', 'article_attachment', 'article_documents'])
           if !uploads.blank?
             system("wkhtmltopdf --page-size Letter --viewport-size 1280x1024  --margin-right 15mm --margin-bottom 20mm #{Rails.application.routes.default_url_options[:host]}/articles/raw_single_print/#{kinship.kin.id} #{Rails.root}/public/pdfs/#{id}/#{kinship.kin.id}.pdf")
             system("convert -density 150 #{Rails.root}/public/pdfs/#{id}/#{uuid}.pdf #{Rails.root}/public/pdfs/#{id}/#{kinship.kin.id}.pdf #{Rails.root}/public/pdfs/#{id}/#{uuid}.pdf")
           end
           for kin_upload in uploads
             system("convert -density 150 #{Rails.root}/public/pdfs/#{id}/#{uuid}.pdf #{kin_upload.attachment.path} #{Rails.root}/public/pdfs/#{id}/#{uuid}.pdf")
           end
         end
         article.pdf_generated = true
         article.save
       end
    end
  end
