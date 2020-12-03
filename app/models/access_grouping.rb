class AccessGrouping < ActiveRecord::Base
  belongs_to :access_group
  after_create :generate_notification

  def generate_notification
    if self.notify
      #Notification.create(user_id: self.user_id, notifiable_type: "Article", notifiable_id: self.article_id, notification_type: "access_grouping", emmiter_id: self.user_id)
    end
  end
end
