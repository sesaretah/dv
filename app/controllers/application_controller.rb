class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  require "jalali_date"
  require "will_paginate/array"
  before_filter :authenticate_user!, :except => [:after_sign_in_path_for, :after_inactive_sign_up_path_for, :after_sign_up_path_for, :raw_print, :raw_single_print]
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :inspect_unicode
  helper_method :xeditable?

  def xeditable?(object = nil)
    true # Or something like current_user.xeditable?
  end

  def inspect_unicode
    fix_unicode_values(nil, params)
  end

  def fix_unicode_values(parent, hash)
    hash.each { |key, value|
      value.is_a?(Hash) ? fix_unicode_values(key, value) : hash[key] = UnicodeFixer.fix(value)
    }
  end

  def configure_permitted_parameters
    update_attrs = [:password, :password_confirmation, :current_password]
    devise_parameter_sanitizer.permit :account_update, keys: update_attrs
  end

  def after_sign_in_path_for(user)
    if !user.profile.blank?
      session["user_return_to"] || "/home"
    else
      "/profiles/new"
    end
  end

  def after_sign_up_path_for(user)
    if !user.profile.blank?
      "/home"
    else
      "/profiles/new"
    end
  end

  def after_inactive_sign_up_path_for(user)
    if !user.profile.blank?
      "/home"
    else
      "/profiles/new"
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
    if !@workflow_state.blank?
      @workflow = article.workflow_state.workflow
      @next_workflow_states = []
      @previous_workflow_states = []
      if !@workflow_state.blank? && !@workflow.blank?
        @next_workflow_states = @workflow.next_nodes(@workflow_state.node_id)
        @previous_workflow_states = @workflow.previous_nodes(@workflow_state.node_id)
      end
      return @next_workflow_states, @previous_workflow_states
    end
  end

  def generate_notfication(**args)
    Notification.create(args)
  end

  def send_mail(**args)
    @command = "node #{Rails.root.join("lib", "nodemailer")}/mailer.js --id #{args[:user_id]} --article_ids #{args[:article_ids]} --role_title '#{args[:role_title]}' --mail_type #{args[:mail_type]} &"
    system(@command)
  end

  def grant_access(ward, user)
    @flag = 0
    if user.assignments.blank?
      return false
    end
    if user.current_role_id.blank?
      return false
    else
      @ac = AccessControl.where(role_id: user.current_role_id).first
      @flag = @ac["#{ward}"].to_i
    end
    if @flag == 0
      return false
    else
      return true
    end
  end

  def article_owner(article, user)
    return true if article.user_id = user.id
    return true if grant_access("edit_workflow", user)
    @role_workflow_state_ids = WorkflowState.where(role_id: user.current_role_id).pluck(:id).uniq
    @user_workflows = user.workflows.pluck(:id)
    if @role_workflow_state_ids.include?(article.workflow_state.id) || @user_workflows.include?(article.workflow_state.workflow.id)
      return true
    else
      return false
    end
  end

  def assign_start_role(user)
    if user.roles.blank?
      @start_point_roles = Role.where(start_point: true)
      for start_point_role in @start_point_roles
        @start_point_assignment = Assignment.where(user_id: user.id, role_id: start_point_role.id)
        if @start_point_assignment.blank?
          @start_point_assignment = Assignment.create(user_id: user.id, role_id: start_point_role.id)
        end
      end
    end
    if !user.roles.blank?
      user.current_role_id = user.roles.first.id if user.current_role_id.blank?
      user.save
    end
  end

  def article_inspect(articles)
    @article_inspect_result = []
    for article in articles
      extract_nxt_prv(article)
      if !article.workflow_state.blank? && !article.workflow_state.workflow.blank?
        @article_inspect_workflow = article.workflow_state.workflow.title
        @article_inspect_workflow_state = article.workflow_state.title
      else
        @article_inspect_workflow = nil
        @article_inspect_workflow_state = nil
      end
      @article_inspect_datings = ""
      for dating in article.datings
        @article_inspect_jalali = JalaliDate.to_jalali(dating.event_date)
        @article_inspect_datings = @article_inspect_datings + " #{dating.article_event.title} : #{@article_inspect_jalali.year}/#{@article_inspect_jalali.month}/#{@article_inspect_jalali.day} | "
      end
      @article_inspect_typings = ""
      for typing in article.typings
        @article_inspect_typings = @article_inspect_typings + "#{typing.article_type.title} | "
      end
      @article_inspect_speakings = ""
      for speaking in article.speakings
        @article_inspect_speakings = @article_inspect_speakings + "#{speaking.language.title} | "
      end
      @article_inspect_formatings = ""
      for formating in article.formatings
        @article_inspect_formatings = @article_inspect_formatings + "#{formating.article_format.title} |"
      end

      @article_inspect_contributours = []
      for contribution in article.contributions
        @article_inspect_contributours << "#{contribution.profile.fullname rescue nil}, #{contribution.duty.title rescue nil}, #{ontribution.role.title rescue nil}"
      end

      @article_inspect_originatings = []
      for originating in article.originatings
        @article_inspect_originatings << "#{originating.article_source.title}"
      end

      @article_inspect_areaings = []
      for areaing in article.areaings
        @article_inspect_areaings << "#{areaing.article_area.title}"
      end

      @article_inspect_kinships = []
      article.kinships.group_by(&:article_relation_type_id).each do |k, v|
        @article_inspect_kinship_titles = ""
        for kinship in v.sort_by!(&:rank)
          @article_inspect_kinship_titles = @article_inspect_kinship_titles + "#{kinship.kin.title}, "
        end
        @article_inspect_kinships << "#{ArticleRelationType.find(k).title}: #{@article_inspect_kinship_titles}"
      end

      @article_inspect_uploads = []
      Upload.where(uploadable_type: "Article", uploadable_id: article.id).group_by(&:attachment_type).each do |k, v|
        @article_inspect_items = []
        for u in v
          @article_inspect_items << { url: request.base_url + u.attachment.url, title: u.title, detail: u.detail }
        end
        @article_inspect_uploads << { title: I18n.t(k), items: @article_inspect_items }
      end
      @article_inspect_owner = false
      if !article.workflow_state.blank? && !article.workflow_state.workflow.blank? && current_user && article.workflow_state.workflow.user_id == current_user.id
        @article_inspect_owner = true
      end
      @article_inspect_votable = false
      if !article.workflow_state.blank? && article.workflow_state.votable == 2
        @article_inspect_votable = true
      end

      @article_inspect_nexts = []
      @article_inspect_previouses = []
      if !article.workflow_state.blank? && current_user && article.workflow_state.role_id == current_user.current_role_id
        for nxt in @next_workflow_states
          @article_inspect_nexts << nxt.title
        end
        for prv in @previous_workflow_states
          @article_inspect_previouses << prv.title
        end
      end
      @article_inspect_result << { id: article.id, title: article.title, abstract: article.abstract, url: article.url, content: ActionController::Base.helpers.sanitize(article.content).gsub("<p>", "").gsub("</p>", ""), workflow_state: @article_inspect_workflow_state, workflow: @article_inspect_workflow, datings: @article_inspect_datings, typings: @article_inspect_typings, speakings: @article_inspect_speakings, formatings: @article_inspect_formatings, uploads: @article_inspect_uploads, votable: @article_inspect_votable, owner: @article_inspect_owner, nexts: @article_inspect_nexts, previouses: @article_inspect_previouses, updated_at: article.updated_at, contributors: @article_inspect_contributours, kinships: @article_inspect_kinships, originatings: @article_inspect_originatings, areaings: @article_inspect_areaings }
    end
    return @article_inspect_result
  end
end
