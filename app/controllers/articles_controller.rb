class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :article_descriptors, :article_related_dates, :article_other_details, :article_contributions, :article_relations, :send_to, :refund_to, :workflow_transitions, :article_detail, :article_logs]

  def search
    if !params[:q].blank?
      @articles = Article.search params[:q], :star => true
    end
    resp = []
    for k in @articles
      resp << {'title' => k.title, 'id' => k.id}
    end
    render :json => resp.to_json, :callback => params['callback']
  end

  def article_descriptors
    @taggings = Tagging.where(taggable_id: @article.id, taggable_type: 'Article', target_type: 'Keyword')
    @keywords = []
    @keyword_ids = []
    for tagging in @taggings
      @keyword = Keyword.find_by_id(tagging.target_id)
      if !@keyword.blank?
        @keyword_ids << @keyword.id
        @keywords << { 'title' => @keyword.title, 'id' => @keyword.id}
      end
    end
  end

  def article_related_dates

  end

  def article_other_details

  end

  def article_contributions

  end

  def article_relations

  end

  def workflow_transitions

  end

  def article_detail

  end

  def article_logs

  end

  def send_to
    @next_workflow_state = WorkflowState.find(params[:workflow_state])
    if @article.workflow_state.workflow.is_next_node(@article.workflow_state.node_id, @next_workflow_state.node_id) && @article.workflow_state.role_id == current_user.current_role_id
      WorkflowTransition.create(workflow_id: @article.workflow_state.workflow.id, from_state_id: @article.workflow_state.id, to_state_id: @next_workflow_state.id, article_id: @article.id, message: params[:message], user_id: current_user.id, role_id: current_user.current_role_id, transition_type: 1 )
      ArticleHistory.create(article_id: @article.id, title: @article.title, abstract: @article.abstract, content: @article.content, url: @article.url, user_id: current_user.id, revision_number: SecureRandom.hex(4))
      @article.workflow_state_id = params[:workflow_state]
      @article.save
    end
  end

  def refund_to
    @previous_workflow_state = WorkflowState.find(params[:workflow_state])
    if @article.workflow_state.workflow.is_previous_node(@article.workflow_state.node_id, @previous_workflow_state.node_id) && @article.workflow_state.role_id == current_user.current_role_id
      WorkflowTransition.create(workflow_id: @article.workflow_state.workflow, from_state_id: @article.workflow_state.id, to_state_id: @previous_workflow_state.id, article_id: @article.id, message: params[:message], user_id: current_user.id, role_id: current_user.current_role_id, transition_type: 2 )
      ArticleHistory.create(article_id: @article.id, title: @article.title, abstract: @article.abstract, content: @article.content, url: @article.url, user_id: current_user.id, revision_number: SecureRandom.hex(4))
      @article.workflow_state_id = params[:workflow_state]
      @article.save
    end
  end
  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @workflow_state = @article.workflow_state
    @workflow = @article.workflow_state.workflow
    if !@workflow_state.blank? && !@workflow.blank?
      @nodes = JSON.parse @workflow.nodes
      @edges = JSON.parse @workflow.edges
      @next_workflow_states = []
      @previous_workflow_states = []
      for edge in @edges
        if edge['source']['id'] ==  @workflow_state.node_id
          @next_workflow_states << WorkflowState.where(node_id: edge['target']['id'], workflow_id: @workflow.id).first
        end
        if edge['target']['id'] ==  @workflow_state.node_id
          @previous_workflow_states << WorkflowState.where(node_id: edge['source']['id'], workflow_id: @workflow.id).first
        end
      end
    end
  end

  # GET /articles/new
  def new
    @article = Article.new
    @workflow_states = WorkflowState.where(role_id: current_user.current_role_id, start_point: 2).group_by(&:workflow_id).keys
    if !@workflow_states.blank?
      @workflows = Workflow.where('id in (?)', @workflow_states )
    else
      redirect_to '/articles', notice: :you_have_not_the_right_permission_to_create_article
    end
  end

  # GET /articles/1/edit
  def edit
    @workflow_states = WorkflowState.where(role_id: current_user.current_role_id).group_by(&:workflow_id).keys
    if !@workflow_states.blank?
      @workflows = Workflow.where('id in (?)', @workflow_states )
    else
      redirect_to '/articles', notice: :you_have_not_the_right_permission_to_create_article
    end
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    if !params[:workflow].blank?
      @workflow_state = WorkflowState.where(workflow_id: params[:workflow].to_i, start_point: 2).first
      @article.workflow_state_id = @workflow_state.id
    end
    @article.save
    params.each do |param|
    if param[0].include?('_title_type')
        @h = param[0].split('_')[0]
        @title_type = TitleType.find_by_id(param[1].to_i)
        Titling.create(title_type_id: @title_type.id, article_id: @article.id, content: params["#{@h}_other_title"] )
      end
    end

    respond_to do |format|
      format.html { redirect_to '/articles/article_descriptors/'+@article.id.to_s , notice: :article_is_created }
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
      respond_to do |format|
      if @article.update(article_params)
        if !params[:keyword].blank?
          @ar = params[:keyword].split(',')
          for a in @ar
            if !a.empty?
              @keyword = Keyword.find_by_id(a.to_i)
              if !@keyword.blank?
                Tagging.create(taggable_type: 'Article', taggable_id: @article.id, target_type: 'Keyword', target_id: @keyword.id)
              end
            end
          end
        end
        if !params[:keyword].blank?
          format.html { redirect_to '/articles/article_related_dates/'+@article.id.to_s, notice: :article_is_updated }
        else
          format.html { redirect_to '/articles/article_descriptors/'+@article.id.to_s, notice: 'Article was successfully updated.' }
        end
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :abstract, :content, :url, :slug,:workflow_state_id)
    end
end
