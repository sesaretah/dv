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

 def grant_access(ward, user)
   if user.assignments.blank?
     return false
   end
   @flag = 1
   for assignment in user.assignments
     @access_control = AccessControl.where(role_id: assignment.role_id).first
     if !@access_control.blank?
       @flag = @flag * @access_control["#{ward}"].to_i
     end
   end
   if @flag == 0
     return false
   else
     return true
   end
 end

end
