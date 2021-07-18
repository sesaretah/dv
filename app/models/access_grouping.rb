class AccessGrouping < ActiveRecord::Base
  belongs_to :access_group
  after_create :generate_notification
  belongs_to :article

  def generate_notification
    if self.notify
      #Notification.create(user_id: self.user_id, notifiable_type: "Article", notifiable_id: self.article_id, notification_type: "access_grouping", emmiter_id: self.user_id)
      users = []
      for role in self.access_group.roles
        for user in role.users
          users << user.id
        end
      end
      uniq_users = users.uniq
      for user in uniq_users
        #prev = AccessGrouping.where('user_id = ? and article_id = ? and created_at < ?', user, self.article_id, 1.day.ago).first
        # if prev.blank?
        Notification.create(user_id: user, notifiable_type: "AccessGrouping", notifiable_id: self.id, notification_type: "access_grouping", emmiter_id: self.user_id)
        #end
      end
    end
  end
end
