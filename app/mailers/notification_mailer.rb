class NotificationMailer < ApplicationMailer
  include ActionView::Helpers::TextHelper

  def notify_email(user_id, notify_type, notifier, notify_text, custom_text, auxiliary_custom_text = nil)
    @user = User.find(user_id)
    @second_pargraph = ""
    @title = "#{t(:notification)}"
    case notify_type
    when "article_sent"
      @body = "#{t(:an_article)} #{t(:with_title)} #{notify_text}  #{t(:article_sent_notification)} "
      #@second_pargraph =  "#{custom_text}"
      @title = "#{t(:new_article_sent)} #{truncate(notify_text)}"
    when "article_received"
      @body = "#{t(:an_article)} #{t(:with_title)} #{notify_text} #{t(:article_received_notification)}  "
      #@second_pargraph =  "#{custom_text}"
      @title = "#{t(:new_article_received)} #{truncate(notify_text)}"
    when "article_refunded"
      @body = "#{t(:an_article)} #{t(:with_title)} #{notify_text}  #{t(:article_sent_notification)}  "
      #@second_pargraph =  "#{custom_text}"
      @title = "#{t(:article_refunded)} #{truncate(notify_text)}"
    when "article_refunded_received"
      @body = "#{t(:an_article)} #{t(:with_title)} #{notify_text} #{t(:article_received_notification)}  "
      #@second_pargraph =  "#{custom_text}"
      @title = "#{t(:article_refunded_received)} #{truncate(notify_text)}"
    when "access_grouping"
      @body = "#{t(:an_article)} #{t(:with_title)} #{notify_text}  #{t(:article_published_notification)} "
      #@second_pargraph =  "#{custom_text}"
      @title = "#{t(:new_article_published)} #{truncate(notify_text)}"
    when "role_assignment"
      @body = "#{t(:role_assignment_notification)}  #{t(:via)} #{notifier} #{t(:onto)} #{notify_text}"
      @second_pargraph = "#{custom_text}"
      @title = "#{t(:new_role_assignment)} #{t(:inside)} #{truncate(notify_text)}"
    when "role_unassignment"
      @body = "#{t(:role_unassignment_notification)}  #{t(:via)} #{notifier} #{t(:onto)} #{notify_text}"
      @second_pargraph = "#{custom_text}"
      @title = "#{t(:new_role_unassignment)} #{t(:inside)} #{truncate(notify_text)}"
    when "change_password"
      @body = "#{t(:change_password_notification)}  #{t(:via)} #{notifier} #{t(:onto)} #{notify_text}"
      @second_pargraph = "#{custom_text}"
      @title = "#{t(:new_change_password)} #{truncate(notify_text)}"
    end

    mail(:to => @user.email,
         :from => "tavan@ut.ac.ir",
         :subject => @title) do |format|
      format.text
      format.html
    end
  end
end
