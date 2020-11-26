class MailerWorker
    include Sidekiq::Worker
    sidekiq_options retry: false
    
    def perform(target_user_id, notification_type, fullname, title, custom_text)
        NotificationMailer.notify_email(target_user_id, notification_type, fullname, title, custom_text).deliver
    end
  end