class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :article_descriptors, :article_related_dates, :article_other_details, :article_contributions, :article_relations, :send_to, :refund_to, :workflow_transitions, :article_detail, :article_logs, :compare]

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

  def compare
    @source_article_history = ArticleHistory.where(revision_number: params[:source]).first
    @target_article_history = ArticleHistory.where(revision_number: params[:target]).first
    @tagging_histories = in_model_compare('TaggingHistory', 'Keyword' ,params[:source], params[:target], 'target_id')
    @dating_histories = in_model_compare('DatingHistory', 'Dating',params[:source], params[:target], 'dating_id')
    @typing_histories = in_model_compare('TypingHistory', 'Typing',params[:source], params[:target], 'typing_id')
    @formating_histories = in_model_compare('FormatingHistory', 'Formating',params[:source], params[:target], 'formating_id')
    @contribution_histories = in_model_compare('ContributionHistory', 'Contribution',params[:source], params[:target], 'contribution_id')
    @kinship_histories = in_model_compare('KinshipHistory', 'Kinship',params[:source], params[:target], 'kinship_id')
    @originating_histories = in_model_compare('OriginatingHistory', 'Originating',params[:source], params[:target], 'originating_id')
    @areaing_histories = in_model_compare('AreaingHistory', 'Areaing',params[:source], params[:target], 'areaing_id')
    @speaking_histories = in_model_compare('SpeakingHistory', 'Speaking',params[:source], params[:target], 'speaking_id')
    @upload_histories = in_model_compare('UploadHistory','Upload',params[:source], params[:target], 'upload_id')
    @result = {sah: @source_article_history, tah: @target_article_history, th: @tagging_histories, dh: @dating_histories, tyh: @typing_histories, fh: @formating_histories, ch: @contribution_histories, kh: @kinship_histories, oh: @originating_histories, ah: @areaing_histories, sh: @speaking_histories, uh: @upload_histories}
  end



  def send_to
    @next_workflow_state = WorkflowState.find(params[:workflow_state])
    @revision_number = SecureRandom.hex(4)
    if @article.workflow_state.workflow.is_next_node(@article.workflow_state.node_id, @next_workflow_state.node_id) && @article.workflow_state.role_id == current_user.current_role_id
      @workflow_transition = WorkflowTransition.create(workflow_id: @article.workflow_state.workflow.id, from_state_id: @article.workflow_state.id, to_state_id: @next_workflow_state.id, article_id: @article.id, message: params[:message], user_id: current_user.id, role_id: current_user.current_role_id, transition_type: 1, revision_number: @revision_number)
      ArticleHistory.create(article_id: @article.id, title: @article.title, abstract: @article.abstract, content: @article.content, url: @article.url, user_id: current_user.id, revision_number: @revision_number , workflow_transition_id: @workflow_transition.id)
      populate_dependencies(@article, @workflow_transition, @revision_number)
      @article.workflow_state_id = params[:workflow_state]
      @article.save
    end
  end



  def refund_to
    @previous_workflow_state = WorkflowState.find(params[:workflow_state])
    @revision_number = SecureRandom.hex(4)
    if @article.workflow_state.workflow.is_previous_node(@article.workflow_state.node_id, @previous_workflow_state.node_id) && @article.workflow_state.role_id == current_user.current_role_id
      @workflow_transition = WorkflowTransition.create(workflow_id: @article.workflow_state.workflow.id, from_state_id: @article.workflow_state.id, to_state_id: @previous_workflow_state.id, article_id: @article.id, message: params[:message], user_id: current_user.id, role_id: current_user.current_role_id, transition_type: 2, revision_number: @revision_number)
      ArticleHistory.create(article_id: @article.id, title: @article.title, abstract: @article.abstract, content: @article.content, url: @article.url, user_id: current_user.id, revision_number: @revision_number , workflow_transition_id: @workflow_transition.id)
      populate_dependencies(@article, @workflow_transition, @revision_number)
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
          extract_keywords(@article, params[:keyword])
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

  def in_model_compare(history_model, model, source, target, index)
    @source = []
    for t in history_model.classify.constantize.where(revision_number: source)
      @source << t[index]
    end
    @target = []
    for t in  history_model.classify.constantize.where(revision_number: target)
      @target << t[index]
    end
    @remainder = model.classify.constantize.where('id IN (?)', @source & @target)
    @new = model.classify.constantize.where('id IN (?)', @target - @source)
    @deleted = model.classify.constantize.where('id IN (?)', @source - @target)
    return {remainder: @remainder, new: @new, deleted: @deleted}
  end

  def populate_dependencies(article, workflow_transition, revision_number)
    for tagging in Tagging.where(taggable_type: 'Article', taggable_id: article.id)
      TaggingHistory.create(tagging_id: tagging.id, taggable_type: 'Article', taggable_id: article.id, target_id: tagging.target_id, target_type: tagging.target_type, article_id: article.id, user_id: current_user.id, revision_number: revision_number , workflow_transition_id: workflow_transition.id)
    end
    for dating in article.datings
      DatingHistory.create(dating_id: dating.id,article_event_id: dating.article_event_id, event_date: dating.event_date, article_id: article.id, user_id: current_user.id, revision_number: revision_number , workflow_transition_id: workflow_transition.id)
    end
    for typing in article.typings
      TypingHistory.create(typing_id: typing.id,article_type_id: typing.article_type_id, article_id: article.id, user_id: current_user.id, revision_number: revision_number , workflow_transition_id: workflow_transition.id)
    end
    for formating in article.formatings
      FormatingHistory.create(formating_id: formating.id,article_format_id: formating.article_format_id, article_id: article.id, user_id: current_user.id, revision_number: revision_number , workflow_transition_id: workflow_transition.id)
    end
    for contribution in article.contributions
      ContributionHistory.create(contribution_id: contribution.id,role_id: contribution.role_id, duty_id: contribution.duty_id, profile_id: contribution.profile_id, article_id: article.id, user_id: current_user.id, revision_number: revision_number , workflow_transition_id: workflow_transition.id)
    end
    for kinship in article.kinships
      KinshipHistory.create(kinship_id: kinship.id,kin_id: kinship.kin_id, article_id: kinship.article_id, article_relation_type_id: kinship.article_relation_type_id , user_id: current_user.id, revision_number: revision_number , workflow_transition_id: workflow_transition.id)
    end
    for originating in article.originatings
      OriginatingHistory.create(originating_id: originating.id, article_id: originating.article_id, article_source_id: originating.article_source_id , user_id: current_user.id, revision_number: revision_number , workflow_transition_id: workflow_transition.id)
    end
    for areaing in article.areaings
      AreaingHistory.create(areaing_id: areaing.id, article_id: areaing.article_id, article_area_id: areaing.article_area_id , user_id: current_user.id, revision_number: revision_number , workflow_transition_id: workflow_transition.id)
    end
    for speaking in article.speakings
      SpeakingHistory.create(speaking_id: speaking.id, article_id: areaing.article_id, language_id: speaking.language_id , user_id: current_user.id, revision_number: revision_number , workflow_transition_id: workflow_transition.id)
    end
    for upload in Upload.where(uploadable_type: 'Article', uploadable_id: article.id, attachment_type: 'article_attachment')
      UploadHistory.create(upload_id: upload.id, uploadable_type: upload.uploadable_type, uploadable_id: upload.uploadable_id, token: upload.token, attachment_file_name: upload.attachment_file_name, attachment_content_type: upload.attachment_content_type, attachment_file_size: upload.attachment_file_size, attachment_updated_at: upload.attachment_updated_at, attachment_type: upload.attachment_type ,user_id: current_user.id, revision_number: revision_number , workflow_transition_id: workflow_transition.id)
    end
  end

  def extract_keywords(article,keywords)
    @taggings = Tagging.where(taggable_type: 'Article', taggable_id: article.id, target_type: 'Keyword')
    for t in @taggings
      t.destroy
    end
    @ar = keywords.split(',')
    for a in @ar.uniq
      if !a.empty?
        @keyword = Keyword.find_by_id(a.to_i)
        if !@keyword.blank?
          @taggings = Tagging.where(taggable_type: 'Article', taggable_id: article.id, target_type: 'Keyword')
          if @tagging.blank?
            Tagging.create(taggable_type: 'Article', taggable_id: article.id, target_type: 'Keyword', target_id: @keyword.id)
          end
        end
      end
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
