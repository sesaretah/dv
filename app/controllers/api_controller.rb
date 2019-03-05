class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :authenticate_user!, :except => [:login, :sign_up, :article, :articles, :dashboard, :roles, :change_role]
  before_action :extract_page, only: [:articles, :dashboard]
  include ActionView::Helpers::TextHelper

  def articles
    if params[:q].blank?
      @articles = Article.all.paginate(:page => params[:page], :per_page => 10)
    else
      @articles = Article.search params[:q], star: true
    end
    @result = article_inspect(@articles)
    render :json => @result.to_json, :callback => params['callback']
  end

  def article
    @articles = []
    @articles << Article.find(params[:id])
    @result = article_inspect(@articles)
    render :json => @result.to_json, :callback => params['callback']
  end

  def dashboard
    @roles = current_user.roles
    @role = Role.find_by_id(current_user.current_role_id)
    if !@role.blank?
      @workflow_state_ids = WorkflowState.where(role_id: @role.id).collect(&:id)
      @articles = Article.where("workflow_state_id IN (?)", @workflow_state_ids).paginate(:page => params[:page], :per_page => 10)
    else
      @articles = []
    end
    @result = article_inspect(@articles)
      render :json => {result: 'OK', articles: @result, roles: @roles, current_role: @role}.to_json , :callback => params['callback']
    #render :json => @result.to_json, :callback => params['callback']
  end

  def roles
    @roles = current_user.roles
    @role = Role.find_by_id(current_user.current_role_id)
    render :json => {result: 'OK', roles: @roles, current_role: @role}.to_json , :callback => params['callback']
  end

  def change_role
    @role = Role.find(params[:role_id])
    @assignment = Assignment.where(role_id: @role.id, user_id: current_user.id)
    if !@assignment.blank?
      current_user.current_role_id = params[:role_id]
      current_user.save
    end
    render :json => {result: 'OK', current_role: @role}.to_json , :callback => params['callback']
  end

  def login
    if User.find_by_email(params['email']).try(:valid_password?, params[:password])
      @user = User.find_by_email(params['email'])
      render :json => {result: 'OK', token: JWTWrapper.encode({ user_id: @user.id }), user_id: @user.id}.to_json , :callback => params['callback']
    else
      render :json => {result: 'ERROR',  error: I18n.t(:doesnt_match) }.to_json , :callback => params['callback']
    end
  end

  def sign_up
    @user = User.new(email: params['email'], password: params['password'], password_confirmation: params['password_confirmation'])
    if @user.save
      @profile = Profile.create(user_id: @user.id, name: params[:name])
      render :json => {result: 'OK', token: JWTWrapper.encode({ user_id: @user.id })}.to_json, :callback => params['callback']
    else
      render :json => {result: 'ERROR', error: @user.errors }.to_json , :callback => params['callback']
    end
  end



  def extract_page
    if !params[:page].blank?
      @page = params[:page]
    else
      @page = 1
    end
  end

end
