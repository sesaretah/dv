class HomeController < ApplicationController
  before_action :authenticate_user!, :except => [:email_sent, :search, :advanced_search]
  before_action :fix_query, :only => [:advanced_search]

  def swap
    source_article = Article.find(params[:source])
    target_article = Article.find(params[:target])
    if !source_article.position.blank? && !target_article.position.blank?
      temp = target_article.position
      target_article.position = source_article.position
      source_article.position = temp
      target_article.save
      source_article.save
    end

    if source_article.position.blank? && !target_article.position.blank?
      temp = target_article.position
      target_article.position = target_article.position + 1
      source_article.position = temp
      target_article.save
      source_article.save
    end

    redirect_to '/home'
  end

  def reports
    if !params[:start_yyyy].blank?
      @start_date = JalaliDate.to_gregorian(params[:start_yyyy],params[:start_mm],params[:start_dd])
    end
    if !params[:end_yyyy].blank?
      @end_date = JalaliDate.to_gregorian(params[:end_yyyy],params[:end_mm],params[:end_dd])
    end
    if !@start_date.blank? && !@end_date.blank?
      @dating_ids = Dating.where('event_date <= ? AND event_date >= ?', @end_date, @start_date).pluck(:article_id)
      @article_ids = Article.where('id IN (?)', @dating_ids).pluck(:id)
    else
      @article_ids = Article.all.pluck(:id)
    end
  end
  def email_sent
    render layout: 'layouts/devise'
  end
  def change_current_role
    @role = Role.find(params[:role_id])
    @assignment = Assignment.where(role_id: @role.id, user_id: current_user.id)
    if !@assignment.blank?
      current_user.current_role_id = params[:role_id]
      current_user.save
    end
  end

  def search
      if user_signed_in?
        redirect_to '/home'
      else
        redirect_to '/users/sign_in'
    #render layout: false
      end
  end

  def index
    @articles = []
    @notifications = []
    @home_setting = home_setting_builder

    if params[:slug] != 'home' && !params[:slug].blank?
      @article = Article.find_by_slug(params[:slug])
      if !@article.blank?
        redirect_to @article
      end
    else
      @role = Role.find_by_id(current_user.current_role_id)
      if !@role.blank?
       # !params[:pp].blank? ? per_page = params[:pp] : per_page = 5
        #!params[:sort].blank? ? sort = params[:sort] : sort = 'created_at'
        #!params[:workflow_state].blank? ? @workflow_state_ids =  [params[:workflow_state].to_i]: @workflow_state_ids = WorkflowState.where(role_id: @role.id).collect(&:id)
       # if  params[:sort] != 'position'
         @home_setting.workflow_state != -1 ? @workflow_state_ids =  [@home_setting.workflow_state.to_i]: @workflow_state_ids = WorkflowState.where(role_id: @role.id).collect(&:id)
         @articles = Article.where("workflow_state_id IN (?)", @workflow_state_ids).order("#{@home_setting.sort}").paginate(:page => params[:page], :per_page => @home_setting.pp)
       # else
       #   @articles = Article.where("workflow_state_id IN (?)", @workflow_state_ids).order("-#{sort} DESC").paginate(:page => params[:page], :per_page => per_page)
      #  end
        @notifications = Notification.where(user_id: current_user.id).order('created_at desc').limit(10)
      end
    end
  end

  def advanced_search
    @model_results = Article.search @query, with: restrict_articles
    @model_results.context[:panes] << ThinkingSphinx::Panes::ExcerptsPane
    @group_results = group_articles(restrict_articles)
    if @query != ''
      @all_results = ThinkingSphinx.search @query, :classes => [Keyword, Profile]
    end
  end

  def restrict_articles
    @h = {
      'tagging_ids' => [],
      'profile_ids'        => [],
      'language_ids'       => [],
      'article_type_ids'   => [],
      'article_format_ids' => [],
      'article_area_ids'   => [],
      'dating_ids' =>  date_filter,
      'article_source_ids' => []
    }
    params.each do |name, value|
      @model = name.split('_')[0]
      case @model
      when 'Profile'
        @h['profile_ids']       << value.to_i
      when 'Language'
        @h['language_ids']      << value.to_i
      when 'ArticleType'
        @h['article_type_ids']   << value.to_i
      when 'ArticleFormat'
        @h['article_format_ids'] << value.to_i
      when 'ArticleArea'
        @h['article_area_ids']   << value.to_i
      when 'ArticleSource'
        @h['article_source_ids'] << value.to_i
      when 'Tagging'
        @h['tagging_ids'] << value.to_i
      end

    end
    return @h
  end

  def date_filter
    @filtered_datings = []
    if params[:start_date_yyyy].blank?
      return []
    else
      @start_date = JalaliDate.to_gregorian(params[:start_date_yyyy],params[:start_date_mm],params[:start_date_dd])
      @end_date = JalaliDate.to_gregorian(params[:end_date_yyyy],params[:end_date_mm],params[:end_date_dd])
      for dating in Dating.all
        if(@start_date.to_date < dating.event_date &&  dating.event_date < @end_date.to_date)
          @filtered_datings << dating.id
        end
      end
      if @filtered_datings.length > 0
        return @filtered_datings
      else
        return [0]
      end
    end
  end


  def group_articles(with_hash)
    @result  = {
      'Tagging' => grouper(Article, @query, 'tagging_ids', with_hash),
      'Profile'       => grouper(Article, @query, 'profile_ids',  with_hash),
      'Language'      => grouper(Article, @query, 'language_ids', with_hash) ,
      'ArticleType'   => grouper(Article, @query, 'article_type_ids', with_hash),
      'ArticleFormat' => grouper(Article, @query, 'article_format_ids', with_hash),
      'ArticleArea'   => grouper(Article, @query, 'article_area_ids', with_hash) ,
      #    'ArticleEvent' => grouper(Article, @query, 'article_event_ids', with_hash),
      'ArticleSource' => grouper(Article, @query, 'article_source_ids', with_hash)

    }
    return @result
  end

  private
  def grouper(model, query, group_by, with_hash)
    return model.search query, with: with_hash, :group_by => group_by,  :order_group_by => 'count(*) desc'
  end

  def home_setting_builder
    home_setting = current_user.home_setting
    if home_setting.blank?
      home_setting = HomeSetting.create(user_id: current_user.id, pp: 5, workflow_state: -1,sort: "-position DESC" )
    end
    home_setting.pp.blank? && params[:pp].blank? ? pp = 5 : pp = params[:pp]
    if !params[:pp].blank? && home_setting.pp != pp
      home_setting.pp = pp
    end
    home_setting.workflow_state.blank? && params[:workflow_state].blank? ? workflow_state = -1 : workflow_state = params[:workflow_state]
    if !params[:workflow_state].blank? && home_setting.workflow_state != workflow_state
      home_setting.workflow_state = workflow_state
    end
    home_setting.sort.blank? && params[:sort].blank? ? sort = "-position DESC" : sort = params[:sort]
    if !params[:sort].blank? && home_setting.sort != sort
      home_setting.sort = sort
    end
    home_setting.save
    return home_setting
  end

  def fix_query
  #  if !params[:q].blank?
  #    @query = params[:q] + '|' + params[:q].gsub('ی','ي').gsub('ک', 'ك') + '|' + params[:q].gsub('ي','ی').gsub('ك', 'ک')
  #  else
  #    @query = ''
  #  end
  @query = params[:q]
  end
end
