class StatePagesController < ApplicationController
  def show
    @state_page = StatePage.where(uuid: params[:uuid]).first
    @article_pre = Article.find(params[:article_id]) if !params[:article_id].blank?
    @new = false
    if !params[:edit].blank? && user_accessible?(@article_pre, current_user)
      @article = @article_pre
    else
      @new = true
      @article = Article.new
    end
  end

  def new
    @state_page = StatePage.new
    @workflow = Workflow.find(params[:workflow_id])
  end

  def new_article
    @state_page = StatePage.where(uuid: params[:uuid]).first
    if params[:article_id].blank?
      @article = Article.create(title: params[:article][:title], user_id: current_user.id, workflow_state_id: @state_page.workflow_state.id, slug: SecureRandom.hex(4))
    else
      @article = Article.find(params[:article_id])
      @article.title = params[:article][:title]
      @article.user_id = current_user.id
      @article.save
    end
    redirect_to "/p/#{@state_page.uuid}?edit=true&article_id=#{@article.id}"
  end

  def edit
    @state_page = StatePage.find(params[:id])
    @workflow = @state_page.workflow_state.workflow
  end

  def index
    @workflow = Workflow.find(params[:id])
    @state_pages = StatePage.where("workflow_state_id in (?)", @workflow.workflow_states.pluck(:id))
  end

  def create
    state_page = StatePage.create(state_page_params)
    @workflow = state_page.workflow_state.workflow
    @state_pages = StatePage.where("workflow_state_id in (?)", @workflow.workflow_states.pluck(:id).uniq).order("workflow_state_id asc")
  end

  def update
    @state_page = StatePage.find(params[:id])
    @state_page.update(state_page_params)
    @workflow = @state_page.workflow_state.workflow
    @state_pages = StatePage.where("workflow_state_id in (?)", @workflow.workflow_states.pluck(:id).uniq).order("workflow_state_id asc")
  end

  def destroy
    @state_page = StatePage.find(params[:id])
    @workflow = @state_page.workflow_state.workflow
    @state_pages = StatePage.where("workflow_state_id in (?)", @workflow.workflow_states.pluck(:id).uniq).order("workflow_state_id asc")
    if !@state_page.blank?
      @state_page.destroy
    end
  end

  def state_page_params
    params.require(:state_page).permit(:workflow_state_id, :item_title, :item_titlings, :item_abstract, :item_url, :item_keywords, :item_datings, :item_typings, :item_speakings, :item_formatings, :item_contributions, :item_kinships, :item_originatings, :item_content, :item_upload, :item_publications, :item_areaings)
  end
end
