class MailerWorker
    include Sidekiq::Worker
    sidekiq_options retry: false

    def perform(target_user_id, notification_type, fullname, title, custom_text, auxiliary_custom_text = nil, article_id = nil)
        NotificationMailer.notify_email(target_user_id, notification_type, fullname, title, custom_text, auxiliary_custom_text, article_id ).deliver
    end
  end
