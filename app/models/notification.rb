class Notification < ActiveRecord::Base
  after_create :notify_by_mail
  include ActionView::Helpers::TextHelper
  belongs_to :user

  def notify_by_mail
    item = self.notifiable_type.classify.constantize.find_by_id(self.notifiable_id)
    return if item.blank?

    article_id = (item.article_id if item.respond_to?(:article_id) && item.article_id.present?)
    fullname   = self.user&.profile&.fullname
    title      = (item.article.title if item.respond_to?(:article) && item.article)

    if NotificationSetting.check(self.user_id, self.notification_type)
      MailerWorker.perform_async(self.user_id, self.notification_type, fullname, title, self.custom_text, "", article_id)
    end

    if self.notifiable_type == "WorkflowTransition" && item.respond_to?(:to_state) && item.to_state.present? && item.to_state.notifiable == 2
      MailerWorker.perform_async(self.user_id, self.notification_type, fullname, title, self.custom_text, "", article_id)
    end
  rescue => e
    # One bad record (missing article, missing profile, etc.) must never abort the
    # surrounding notification batch — log and move on so the rest still get notified.
    Rails.logger.error("Notification#notify_by_mail failed: notification=#{self.id} user=#{self.user_id} type=#{self.notification_type}: #{e.class}: #{e.message}")
    nil
  end

  def icon
    case self.notification_type
    when "article_sent"
      return "<i class='fe fe-trending-up' style='color:#7bd235;vertical-align: -3px;'></i>"
    when "article_received"
      return "<i class='fe fe-arrow-left' style='color:#7bd235;vertical-align: -3px;'></i>"
    when "article_refunded"
      return "<i class='fe fe-trending-down' style='color:#e4405f;vertical-align: -3px;'></i>"
    when "article_refunded_received"
      return "<i class='fe fe-arrow-left' style='color:#e4405f;vertical-align: -3px;'></i>"
    when "article_comment"
      return "<i class='fe fe-message-square' style='color:#467fcf;vertical-align: -3px;'></i>"
    end
  end

  def title
    @item = self.notifiable_type.classify.constantize.find_by_id(self.notifiable_id)
    if !@item.article.blank?
      case self.notification_type
      when "article_sent"
        return "<div class='small text-muted'>#{truncate(@item.article.title, length: 29)}</div><div style='font-size:smaller;'>#{truncate(@item.message, length: 29)}</div>"
      when "article_received"
        return "<div class='small text-muted'>#{truncate(@item.article.title, length: 29)}</div><div style='font-size:smaller;'>#{truncate(@item.message, length: 29)}</div>"
      when "article_refunded"
        return "<div class='small text-muted'>#{truncate(@item.article.title, length: 29)}</div><div style='font-size:smaller;'>#{truncate(@item.message, length: 29)}</div>"
      when "article_refunded_received"
        return "<div class='small text-muted'>#{truncate(@item.article.title, length: 29)}</div><div style='font-size:smaller;'>#{truncate(@item.message, length: 29)}</div>"
      when "article_comment"
        return "<div class='small text-muted'>#{truncate(@item.article.title, length: 29)}</div><div style='font-size:smaller;'>#{truncate(@item.content, length: 29)}</div>"
      end
    end
  end

  def full_title
    @item = self.notifiable_type.classify.constantize.find_by_id(self.notifiable_id)
    if !@item.article.blank?
      case self.notification_type
      when "article_sent"
        return "<div class='small text-muted'>#{@item.article.title}</div><div style='font-size:smaller;'>#{@item.message}</div>"
      when "article_received"
        return "<div class='small text-muted'>#{@item.article.title}</div><div style='font-size:smaller;'>#{@item.message}</div>"
      when "article_refunded"
        return "<div class='small text-muted'>#{@item.article.title}</div><div style='font-size:smaller;'>#{@item.message}</div>"
      when "article_refunded_received"
        return "<div class='small text-muted'>#{@item.article.title}</div><div style='font-size:smaller;'>#{@item.message}</div>"
      when "article_comment"
        return "<div class='small text-muted'>#{@item.article.title}</div><div style='font-size:smaller;'>#{@item.content}</div>"
      end
    end
  end

  def valid
    @item = self.notifiable_type.classify.constantize.find_by_id(self.notifiable_id)
    if !@item.blank?
      return true
    else
      return false
    end
  end
end
