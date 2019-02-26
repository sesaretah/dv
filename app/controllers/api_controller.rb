class ApiController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :authenticate_user!, :except => [:login, :sign_up, :article, :articles]
  before_action :extract_page, only: [:articles, :dashboard]
  include ActionView::Helpers::TextHelper

  def articles
    if params[:q].blank?
      @articles = Article.all.paginate(:page => params[:page], :per_page => 10)
    else
      @articles = Article.search params[:q], star: true
    end
    article_detail
    render :json => @result.to_json, :callback => params['callback']
  end

  def article
    @articles = []
    @articles << Article.find(params[:id])
    article_detail
    render :json => @result.to_json, :callback => params['callback']
  end

  def dashboard
    @role = Role.find_by_id(current_user.current_role_id)
    if !@role.blank?
      @workflow_state_ids = WorkflowState.where(role_id: @role.id).collect(&:id)
      @articles = Article.where("workflow_state_id IN (?)", @workflow_state_ids).paginate(:page => params[:page], :per_page => 10)
    else
      @articles = []
    end
    article_detail
    render :json => @result.to_json, :callback => params['callback']
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

  def article_detail
    @result = []
    for article in @articles
      if !article.workflow_state.blank? && !article.workflow_state.workflow.blank?
        @workflow= article.workflow_state.workflow.title
        @workflow_state= article.workflow_state.title
      else
        @workflow= nil
        @workflow_state= nil
      end
      @datings = ''
      for dating in article.datings
        @jalali = JalaliDate.to_jalali(dating.event_date)
        @datings = @datings +  " #{dating.article_event.title} : #{@jalali.year}/#{@jalali.month}/#{@jalali.day} | "
      end
      @typings = ''
      for typing in article.typings
        @typings  = @typings + "#{typing.article_type.title} | "
      end
      @speakings = ''
      for speaking in article.speakings
        @speakings = @speakings + "#{speaking.language.title} | "
      end
      @formatings = ''
      for formating in article.formatings
        @formatings = @formatings + "#{formating.article_format.title} |"
      end
      @uploads = []
      Upload.where(uploadable_type: 'Article', uploadable_id: article.id).group_by(&:attachment_type).each do |k,v|
        @items = []
        for u in v
          @items << {url: request.base_url + u.attachment.url, title: u.title, detail: u.detail}
        end
        @uploads << {title: I18n.t(k), items: @items}
      end
      @result << {id: article.id, title: article.title, abstract: article.abstract, content: article.content, workflow_state: @workflow_state, workflow: @workflow, datings: @datings, typings: @typings, speakings: @speakings, formatings: @formatings, uploads: @uploads, updated_at: article.updated_at}
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
