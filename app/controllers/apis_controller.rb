class ApisController < ApplicationController
  protect_from_forgery with: :null_session,
    if: Proc.new { |c| c.request.format =~ %r{application/json} }
  before_action :authenticate_user!, :except => [:comments_api]
  def comments_api
    logger.debug params.inspect
    if !params[:content].blank?
      @article = Article.new
      @article.content = params[:content]
      @article.save
    else
    #  render :json => {result: 'error', description: 'Content cannot be blank!'}.to_json
    end
    if !@article.blank? && !params[:date].blank?
      @article_event = ArticleEvent.where(title: t(:publish_date)).first
      if @article_event.blank?
        @article_event = ArticleEvent.create(title: t(:publish_date))
      end
      @date = date_sanity_check(params[:date])
      @dating = Dating.create(article_event_id: @article_event.id, article_id: @article.id, event_date: @date)
    end
    if !@article.blank? && !params[:name].blank? && params[:name] != 'A Google user'
      @profile = Profile.where(stage_name: params[:name]).first
      if @profile.blank?
        @profile = Profile.create(stage_name: params[:name])
      end
      @role = Role.where(title: t(:comment_author)).first
      if @role.blank?
        @role = Role.create(title: t(:comment_author))
      end
      @contribution = Contribution.create(role_id: @role.id, profile_id: @profile.id, article_id: @article.id)
    end
  #  render :json =>  {result: 'success'}.to_json
  end

end
