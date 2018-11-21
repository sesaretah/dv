class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  require 'jalali_date'
  before_filter :authenticate_user!, :except => [:after_sign_in_path_for,:after_inactive_sign_up_path_for,     :after_sign_up_path_for]
  before_filter :configure_permitted_parameters, if: :devise_controller?


 def configure_permitted_parameters
 end

 def after_sign_in_path_for(user)
   if !user.profile.blank?
     session['user_return_to'] || root_path
   else
     '/profiles/new'
   end
 end

 def after_sign_up_path_for(user)
   if !user.profile.blank?
     root_path
   else
     '/profiles/new'
   end
 end

 def after_inactive_sign_up_path_for(user)
   if !user.profile.blank?
     root_path
   else
     '/profiles/new'
   end
 end

 def owner(obj, user)
   if obj.user_id == user.id
     return true
   else
     return false
   end
 end

 def date_sanity_check(str)
   return Date.parse str
 end

 def extract_nxt_prv(article)
   @workflow_state = article.workflow_state
   @workflow = article.workflow_state.workflow
   @next_workflow_states = []
   @previous_workflow_states = []
   if !@workflow_state.blank? && !@workflow.blank?
     @next_workflow_states = @workflow.next_nodes(@workflow_state.node_id)
     @previous_workflow_states =  @workflow.previous_nodes(@workflow_state.node_id)
   end
   return @next_workflow_states, @previous_workflow_states
 end

 def generate_notfication(**args)
   Notification.create(args)
 end

 def send_mail(**args)
   @command = "node #{Rails.root.join('lib', 'nodemailer')}/mailer.js --id #{args[:user_id]} --article_ids #{args[:article_ids]} --role_title '#{args[:role_title]}' --mail_type #{args[:mail_type]} &"
   system(@command)
 end

 def grant_access(ward, user)
   if user.assignments.blank?
     return false
   end
   @flag = 1
   for assignment in user.assignments
     @ac = AccessControl.where(role_id: assignment.role_id).first
     if !@ac.blank?
       @flag = @flag * @ac["#{ward}"].to_i
     end
   end
   if @flag == 0
     return false
   else
     return true
   end
 end

end
