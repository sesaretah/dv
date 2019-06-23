class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :article_descriptors, :article_related_dates, :article_other_details, :article_contributions, :article_relations, :send_to, :refund_to, :workflow_transitions, :article_detail, :article_logs, :compare, :article_states, :article_comments, :print, :change_workflow, :make_a_copy, :article_publishable, :change_access_group, :sectioned_form ]

  def sectioned_form
    @section = Section.find(params[:section_id])
  end

  def title_search
    if !params[:q].blank?
      @articles = Article.search :conditions => {:title => params[:q]}, :star => true
    end
    resp = []
    for r in @articles
      resp << {'title' => r.title , 'id' => r.id}
    end
    render :json => resp.to_json, :callback => params['callback']
  end

  def print
    @word_tempate = WordTemplate.find(params[:word_template])
    @articles = []
    @articles << Article.find(params[:id])
    @result = article_inspect(@articles)
    #render layout: 'layouts/devise'
    respond_to do |format|
      format.docx do
        # Initialize DocxReplace with your template
        doc = DocxReplace::Doc.new("#{@word_tempate.document.path}", "#{Rails.root}/tmp")

        # Replace some variables. $var$ convention is used here, but not required.
        doc.replace("1000101", @result[0][:title])
        doc.replace("1000102", @result[0][:abstract])
        doc.replace("1000103", @result[0][:url])
        doc.replace("1000104", @result[0][:datings])
        doc.replace("1000105", @result[0][:typings])
        doc.replace("1000106", @result[0][:speakings])
        doc.replace("1000107", @result[0][:formatings])
        doc.replace("1000108", @result[0][:contributors].map(&:inspect).join(', '))
        doc.replace("1000109", @result[0][:kinships].map(&:inspect).join(', '))
        doc.replace("1000110", @result[0][:contributors].map(&:inspect).join(', '))
        doc.replace("1000111", @result[0][:originatings].map(&:inspect).join(', '))
        doc.replace("1000112", @result[0][:areaings].map(&:inspect).join(', '))
        doc.replace("1000113", @result[0][:content])

        # Write the document back to a temporary file
        tmp_file = Tempfile.new("word_tempate_#{SecureRandom.hex(10)}", "#{Rails.root}/tmp")
        doc.commit(tmp_file.path)

        # Respond to the request by sending the temp file
        send_file tmp_file.path, filename: "#{@article.id}.docx", disposition: 'attachment'
      end
    end
  end

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

  def change_access_group
    @article.access_group_id = params[:access_group_id]
    @article.save
  end

  def article_publishable

  end


  def article_descriptors

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
    if !grant_access("view_workflow_transactions", current_user)
      head(403)
    end
  end

  def article_detail
  end

  def article_logs
    if !grant_access("view_article_logs", current_user)
      head(403)
    end
  end

  def article_comments

  end

  def article_states
    extract_nxt_prv(@article)
    @workflow_states = WorkflowState.where(role_id: current_user.current_role_id, start_point: 2).group_by(&:workflow_id).keys
    @workflows = Workflow.where('id in (?)', @workflow_states )
  end

  def change_workflow
    #    if @article.workflow_state.workflow.id ==
    @article.workflow_state_id = params[:workflow_state_id]
    @article.save
    extract_nxt_prv(@article)
  end

  def make_a_copy
    @workflow = Workflow.find(params[:workflow_id])
    if @article.workflow_state.workflow.id != @workflow.id
      @flag = true
      @new_article = Article.create(title: @article.title, abstract: @article.abstract, content: @article.content, url: @article.url, document_contents: @article.document_contents, content_wo_tags: @article.content_wo_tags, workflow_state_id: @workflow.start_state.id, slug: SecureRandom.hex(4))
      @taggings = Tagging.where(taggable_type: 'Article', taggable_id: @article.id, target_type: 'Keyword')
      for t in @taggings
        Tagging.where(taggable_type: 'Article', taggable_id: @new_article.id, target_id: t.target_id ,target_type: 'Keyword')
      end
      @article_relation_type = ArticleRelationType.find(params[:article_relation_type_id])
      Kinship.create(kin_id: @article.id, article_id: @new_article.id, user_id: current_user.id, article_relation_type_id: @article_relation_type.id)
      @uploads = Upload.where(uploadable_type: 'Article', uploadable_id: @article.id)
      for upload in @uploads
        Upload.create(uploadable_type: 'Article', uploadable_id: @new_article.id, attachment_file_name: upload.attachment_file_name, attachment_content_type: upload.attachment_content_type, attachment_file_size: upload.attachment_file_size, attachment_type: upload.attachment_type, title: upload.title, detail: upload.detail)
      end
    else
      @flag = false
    end
  end


  def compare
    @result = {
      sah: ArticleHistory.where(revision_number: params[:source]).first,
      tah: ArticleHistory.where(revision_number: params[:target]).first,
      th: history(model:'Keyword', params: params, alias: 'Tagging', model_key: 'target_id'),
      dh: history(model: 'Dating', params: params),
      tyh: history(model: 'Typing', params: params),
      fh: history(model: 'Formating', params: params),
      ch: history(model: 'Contribution', params: params),
      kh: history(model: 'Kinship', params: params),
      oh: history(model: 'Originating', params: params),
      ah: history(model: 'Areaing', params: params),
      sh: history(model: 'Speaking', params: params),
      uh: history(model: 'Upload', params: params)
    }
  end


  def send_to
    @this_workflow_state = @article.workflow_state
    @next_workflow_state = WorkflowState.find(params[:workflow_state])
    @this_role = @this_workflow_state.role
    @next_role = @next_workflow_state.role
    @revision_number = SecureRandom.hex(4)
    if @article.workflow_state.workflow.is_next_node(@article.workflow_state.node_id, @next_workflow_state.node_id) && @article.workflow_state.role_id == current_user.current_role_id
      @workflow_transition = WorkflowTransition.create(workflow_id: @article.workflow_state.workflow.id, from_state_id: @article.workflow_state.id, to_state_id: @next_workflow_state.id, article_id: @article.id, message: params[:message], user_id: current_user.id, role_id: current_user.current_role_id, transition_type: 1, revision_number: @revision_number)
      populate_dependencies(@article, @workflow_transition, @revision_number)
      @article.workflow_state_id = params[:workflow_state]
      @article.save
    end
    extract_nxt_prv(@article)
    if !@this_role.blank?
      for user in @this_role.users
        generate_notfication user_id: user.id , notifiable_type: 'WorkflowTransition', notifiable_id: @workflow_transition.id, notification_type: 'article_sent', emmiter_id: current_user.id
      end
    end
    if !@next_role.blank?
      for user in @next_role.users
        generate_notfication user_id: user.id , notifiable_type: 'WorkflowTransition', notifiable_id: @workflow_transition.id, notification_type: 'article_received', emmiter_id: current_user.id
      end
    end
    #send_mail user_id: @role.users.pluck(:id).join(','), article_ids: @article.id, mail_type: 'article_sent'
  end



  def refund_to
    @this_workflow_state = @article.workflow_state
    @previous_workflow_state = WorkflowState.find(params[:workflow_state])
    @this_role = @this_workflow_state.role
    @prv_role = @previous_workflow_state.role
    @revision_number = SecureRandom.hex(4)
    if @article.workflow_state.workflow.is_previous_node(@article.workflow_state.node_id, @previous_workflow_state.node_id) && @article.workflow_state.role_id == current_user.current_role_id
      @workflow_transition = WorkflowTransition.create(workflow_id: @article.workflow_state.workflow.id, from_state_id: @article.workflow_state.id, to_state_id: @previous_workflow_state.id, article_id: @article.id, message: params[:message], user_id: current_user.id, role_id: current_user.current_role_id, transition_type: 2, revision_number: @revision_number)
      populate_dependencies(@article, @workflow_transition, @revision_number)
      @article.workflow_state_id = params[:workflow_state]
      @article.save
    end
    extract_nxt_prv(@article)
    if !@prv_role.blank?
      for user in @prv_role.users
        generate_notfication user_id: user.id , notifiable_type: 'WorkflowTransition', notifiable_id: @workflow_transition.id, notification_type: 'article_refunded_received', emmiter_id: current_user.id
      end
    end
    if !@this_role.blank?
      for user in @this_role.users
        generate_notfication user_id: user.id , notifiable_type: 'WorkflowTransition', notifiable_id: @workflow_transition.id, notification_type: 'article_refunded', emmiter_id: current_user.id
      end
    end

  end
  # GET /articles
  # GET /articles.json
  def index
    @role = Role.find_by_id(current_user.current_role_id)
    if !@role.blank? && !grant_access("view_unrelated_articles", current_user)
      @workflow_state_ids = WorkflowState.where(role_id: @role.id).collect(&:id)
      @articles = Article.where("workflow_state_id IN (?)", @workflow_state_ids).paginate(:page => params[:page], :per_page => 5)
    else
      @articles = Article.paginate(:page => params[:page], :per_page => 5)
    end
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    extract_nxt_prv(@article)
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
    if !article_owner(@article, current_user)
      head(403)
    else
      @workflow_states = WorkflowState.where(role_id: current_user.current_role_id).group_by(&:workflow_id).keys
      if !@workflow_states.blank?
        @workflows = Workflow.where('id in (?)', @workflow_states )
      end
    end
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = Article.new(article_params)
    if @article.slug.blank?
      @article.slug = SecureRandom.hex(4)
    end
    if !params[:workflow].blank?
      @workflow_state = WorkflowState.where(workflow_id: params[:workflow].to_i, start_point: 2).first
      @article.workflow_state_id = @workflow_state.id
    end
    @article.save
    extract_other_titles
    respond_to do |format|
      if params[:form_type] == 'custom'
        format.html { redirect_to '/articles/sectioned_form/'+@article.id.to_s+'?section_id='+ @article.start_section , notice: :article_is_created }
      else
        format.html { redirect_to '/articles/article_descriptors/'+@article.id.to_s , notice: :article_is_created }
      end

    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    if @article.slug.blank?
      @article.slug = SecureRandom.hex(4)
    end
  #  @article.document_contents = ''
  #  for upload in @article.uploads
  #    @text =  %x[java -jar #{Rails.root}/lib/tika-app-1.20.jar -h #{upload.attachment.path}]
  #    if !@text.blank?
  #      @article.document_contents =  @article.document_contents + ' ' + @text
  #    end
  #  end
    if !params[:article].blank? && !params[:article][:content].blank?
      @article.content_wo_tags = ActionView::Base.full_sanitizer.sanitize(params[:article][:content])
    end
    respond_to do |format|
      if @article.update(article_params)
        if !params[:keyword].blank? || params[:keyword] == ''
          extract_keywords(@article, params[:keyword])
        end
        if params[:caller] != 'descriptors'
          extract_other_titles
        end
        if params[:caller] == 'descriptors'
          format.html { redirect_to '/articles/article_related_dates/'+@article.id.to_s, notice: :article_is_updated }
        else
          format.html { redirect_to '/articles/article_descriptors/'+@article.id.to_s, notice: :article_is_updated }
        end
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.js
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    if !article_owner(@article, current_user)
      head(403)
    else
      @article.destroy
      redirect_to '/articles'
    end
  end


  def extract_other_titles
    for titling in @article.titlings
      titling.destroy
    end
    params.each do |param|
      if param[0].include?('_title_type')
        @h = param[0].split('_')[0]
        if !params["#{@h}_other_title"].blank?
          @title_type = TitleType.find_by_id(param[1].to_i)
          Titling.create(title_type_id: @title_type.id, article_id: @article.id, content: params["#{@h}_other_title"] )
        end
      end
    end
  end


  def history(**args)
    if args[:alias].blank?
      return in_model_compare("#{args[:model]}History", args[:model], args[:params][:source], args[:params][:target], "#{args[:model].downcase}_id")
    else
      return in_model_compare("#{args[:alias]}History", args[:model], args[:params][:source], args[:params][:target], args[:model_key])
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
    ArticleHistory.create(article_id: article.id, title: article.title, abstract: article.abstract, content: article.content, url: article.url, user_id: current_user.id, revision_number: revision_number , workflow_transition_id: workflow_transition.id)
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
      SpeakingHistory.create(speaking_id: speaking.id, article_id: speaking.article_id, language_id: speaking.language_id , user_id: current_user.id, revision_number: revision_number , workflow_transition_id: workflow_transition.id)
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
    params.require(:article).permit(:title, :abstract, :content, :url, :slug,:workflow_state_id, :retrieval_number, :dimensions, :notes, :description)
  end
end
