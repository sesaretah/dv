class HomeController < ApplicationController
  before_action :authenticate_user!, :except => [:email_sent]
  before_action :fix_query, :only => [:advanced_search]
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

  def index
    if !params[:slug].blank?
      @article = Article.find_by_slug(params[:slug])
      if !@article.blank?
        redirect_to @article
      end
    else
      @role = Role.find_by_id(current_user.current_role_id)
      if !@role.blank?
        @workflow_state_ids = WorkflowState.where(role_id: @role.id).collect(&:id)
        @articles = Article.where("workflow_state_id IN (?)", @workflow_state_ids).paginate(:page => params[:page], :per_page => 5)
        @notifications = Notification.where(user_id: current_user.id).order('created_at desc').limit(10)
      else
        @articles = []
        @notifications = []
      end
    end
  end

  def advanced_search
    @model_results = Article.search @query, :page => params[:page], :per_page => 15, with: restrict_articles
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

  def group_articles(with_hash)
    @result  = {
      'Tagging' => grouper(Article, @query, 'tagging_ids', with_hash),
      'Profile'       => grouper(Article, @query, 'profile_ids',  with_hash),
      'Language'      => grouper(Article, @query, 'language_ids', with_hash) ,
      'ArticleType'   => grouper(Article, @query, 'article_type_ids', with_hash),
      'ArticleFormat' => grouper(Article, @query, 'article_format_ids', with_hash),
      'ArticleArea'   => grouper(Article, @query, 'article_area_ids', with_hash) ,
      'ArticleSource' => grouper(Article, @query, 'article_source_ids', with_hash)

    }
    return @result
  end

  private
  def grouper(model, query, group_by, with_hash)
    return model.search query, with: with_hash, :group_by => group_by,  :order_group_by => 'count(*) desc'
  end

  def fix_query
    if !params[:q].blank?
      @query = "#{params[:q]} | #{params[:q].gsub('ی','ي')} | #{params[:q].gsub('ي','ی')} | #{params[:q].gsub('ک', 'ك')} | #{params[:q].gsub('ك', 'ک')} "
    else
      @query = ''
    end
  end
end
