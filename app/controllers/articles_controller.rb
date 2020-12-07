class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy, :article_descriptors, :article_related_dates, :article_other_details, :article_contributions, :article_relations, :send_to, :refund_to, :workflow_transitions, :article_detail, :article_logs, :compare, :article_states, :article_comments, :print, :change_workflow, :make_a_copy, :article_publishable, :change_access_group, :sectioned_form, :raw_print, :content_form , :set_note_template, :add_access_group, :remove_access_group]
  
  def add_access_group
    if !params[:access_group_id].blank?
      p params[:notify]
      p '######'
       @access_grouping = AccessGrouping.where(article_id: @article.id, access_group_id: params[:access_group_id]).first
      if @access_grouping.blank?
        @access_grouping = AccessGrouping.create(article_id: @article.id, access_group_id: params[:access_group_id], notify: params[:notify])
      end
      @access_groupings = AccessGrouping.where(article_id: @article.id)
    end
  end

  def remove_access_group
    if !params[:access_grouping_id].blank?
       @access_grouping = AccessGrouping.find_by_id(params[:access_grouping_id])
      if !@access_grouping.blank?
        @access_grouping.destroy
      end
      @access_groupings = AccessGrouping.where(article_id: @article.id)
    end
  end
  
  def set_note_template
    Noting.create(article_id: @article.id, note_template_id: params[:note_template_id])
  end

  def content_form

  end
  
  def fixer
    for article in Article.all
      article.abstract = UnicodeFixer.fix(article.abstract)
      article.title = UnicodeFixer.fix(article.title)
      article.content = UnicodeFixer.fix(article.content)
      article.content_wo_tags = UnicodeFixer.fix(article.content_wo_tags)
      article.save
    end
  end

  def upload_indexer
    #article = Article.find(params[:id])
    for article in Article.all
      article.document_contents = ''
      for upload in article.uploads
        text =  %x[java -jar #{Rails.root}/lib/tika-app-1.20.jar -h #{upload.attachment.path}]
        if !text.blank?
          article.document_contents =  article.document_contents + ' ' + text
        end
      end
      article.save
    end
  end


  def csv_to_db
    require 'csv'
    xlsx = Roo::Spreadsheet.open("#{Rails.root}/data.xlsx")

    xlsx.each_row_streaming( offset: 1, max_rows: 1071) do |row|
      article = Article.new
      if !row[0].blank?
        article.title = row[0].to_s.truncate(200)
      end
      if !row[3].blank?
        article.abstract = row[3].to_s.truncate(200)
      end
      if !row[4].blank? && !row[5].blank?
        article.description = row[4].to_s.truncate(200) +' | '+ row[5].to_s.truncate(200)
      end
      if !row[6].blank?
        article.content = row[6].to_s.truncate(200)
      end

      if !row[7].blank?
        article.url = row[7].to_s.truncate(200)
      end
      article.slug = SecureRandom.hex(4)
      article.workflow_state_id = 1
      article.save
      areas = row[17].to_s.split('،')
      for area in areas
        a = ArticleArea.where(title: area.squish).first
        if a.blank?
          a = ArticleArea.create(title: area.squish)
        end
        if !a.blank?
          Areaing.create(article_area_id:  a.id, article_id: article.id)
        end
      end

      types = row[12].to_s.split('،')
      for type in types
        t = ArticleType.where(title: type.squish).first
        if t.blank?
          t = ArticleType.create(title: type.squish)
        end
        if !t.blank?
          Typing.create(article_type_id:  t.id, article_id: article.id)
        end
      end



      keyword_1 = Keyword.where(title: row[8].to_s.squish).first
      if !row[8].blank? && keyword_1.blank?
        keyword_1 = Keyword.create(title: row[8])
      end
      if !keyword_1.blank?
        Tagging.create(taggable_type: 'Article', taggable_id: article.id, target_type: 'Keyword', target_id: keyword_1.id)
      end

      keyword_2 = Keyword.where(title: row[9].to_s.squish).first
      if !row[8].blank? && keyword_2.blank?
        keyword_2 = Keyword.create(title: row[9])
      end
      if !keyword_2.blank?
        Tagging.create(taggable_type: 'Article', taggable_id: article.id, target_type: 'Keyword', target_id: keyword_2.id)
      end
      
      Speaking.create(language_id: 1, article_id: article.id)
      Formating.create(article_format_id: 1, article_id: article.id)
      Contribution.create(article_id: article.id, profile_id: 492, role_id: 62, duty_id: 70)
      if !row[1].blank?
        Titling.create(article_id: article.id, title_type_id: 1, content: row[1].to_s.squish)
      end
      if !row[2].blank?
        Titling.create(article_id: article.id, title_type_id: 3, content: row[2].to_s.squish)
      end
      if !row[10].blank?
        date = row[10].to_s.split('/')
        dating = Dating.new
        jdate = JalaliDate.to_gregorian(date[0],date[1],date[2]) rescue nil
        if jdate
          dating.article_id = article.id
          dating.article_event_id = ArticleEvent.last.id
          dating.event_date = jdate
          dating.save rescue nil
        end
      end
    end
  end

  def csv_to_db_2
    require 'csv'
    xlsx = Roo::Spreadsheet.open("#{Rails.root}/data#{params[:id]}.xlsx")

    xlsx.each_row_streaming( offset: 1, max_rows: 500, pad_cells: true) do |row|
      article = Article.new
      if !row[1].blank?
        article.title = row[1].to_s.truncate(200)
      end
      if !row[2].blank?
        article.abstract = row[3].to_s.truncate(200)
      end
      notes = ' '
      if !row[3].blank? 
        notes += row[3].to_s.truncate(200) +' | '
      end

      if !row[4].blank? 
        notes += row[4].to_s.truncate(200) +' | '
      end

      if !row[5].blank? 
        notes += row[5].to_s.truncate(200) +' | '
      end

      if !row[6].blank? 
        notes += row[6].to_s.truncate(200) +' | '
      end

      article.notes = notes
      if !row[7].blank?
        article.content = row[7].to_s.truncate(200)
      end

      if !row[8].blank?
        article.url = row[8].to_s.truncate(200)
      end
      article.slug = SecureRandom.hex(4)
      article.workflow_state_id = 1
      article.save

      areas = row[18].to_s.split('،')
      for area in areas
        a = ArticleArea.where(title: area.squish).first
        if a.blank?
          a = ArticleArea.create(title: area.squish)
        end
        if !a.blank?
          Areaing.create(article_area_id:  a.id, article_id: article.id)
        end
      end

      types = row[11].to_s.split('،')
      for type in types
        t = ArticleType.where(title: type.squish).first
        if t.blank?
          t = ArticleType.create(title: type.squish)
        end
        if !t.blank?
          Typing.create(article_type_id:  t.id, article_id: article.id)
        end
      end

      keywords = row[9].to_s.split('؛')
      for keyword in keywords
        k = Keyword.where(title: keyword.squish).first
        if k.blank?
          k = Keyword.create(title: keyword.squish)
        end
          Tagging.create(taggable_type: 'Article', taggable_id: article.id, target_type: 'Keyword',  target_id:  k.id)
      end

      
      Speaking.create(language_id: 1, article_id: article.id)
      Formating.create(article_format_id: 1, article_id: article.id)
      Contribution.create(article_id: article.id, profile_id: 492, role_id: 62, duty_id: 70)
      if !row[10].blank?
        dating = Dating.new
        jdate = JalaliDate.to_gregorian(row[10].to_s,1,1) rescue nil
        if jdate
          dating.article_id = article.id
          dating.article_event_id = ArticleEvent.last.id
          dating.event_date = jdate
          dating.save rescue nil
        end
      end
    end
  end

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

  def raw_print
    render layout:false
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
      @articles = Article.search UnicodeFixer.fix(params[:q]), :star => true
    end
    if params[:domain] == 'workflow'
      article = Article.find(params[:article_id])
      @workflow_state_ids = article.workflow_state.workflow.workflow_states.pluck(:id)
      @articles = Article.search UnicodeFixer.fix(params[:q]), :star => true, with: {:workflow_state_id => @workflow_state_ids}
    end
    resp = []
    for k in @articles
      resp << {'title' => k.title, 'id' => k.id}
    end
    render :json => resp.to_json, :callback => params['callback']
  end

  def change_access_group
    @article.access_group_id = params[:access_group_id]
    @article.publish_details = params[:publish_details]
    @article.access_for_others = params[:access_for_others]
    if params[:publish_related]
      for kinship in @article.kinships
        kinship.kin.publish_details = params[:publish_details]
        kinship.kin.access_for_others = params[:access_for_others]
        for access_grouping in @article.access_groupings
          kin_grouping = AccessGrouping.where(article_id: kinship.kin.id, access_group_id: access_grouping.access_group_id).first
          if kin_grouping.blank?
            AccessGrouping.create(article_id: kinship.kin.id, access_group_id: access_grouping.access_group_id, notify: access_grouping.notify)
          end
        end
        kinship.kin.save
      end
    end
    @article.save
  end

  def article_publishable
    @access_groupings = AccessGrouping.where(article_id: @article.id)
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
      #ch: history(model: 'Contribution', params: params),
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
        if !user.blank? && !@workflow_transition.blank?
          generate_notfication user_id: user.id , notifiable_type: 'WorkflowTransition', notifiable_id: @workflow_transition.id, notification_type: 'article_sent', emmiter_id: current_user.id
        end
      end
    end
    if !@next_role.blank?
      for user in @next_role.users
        if !user.blank? && !@workflow_transition.blank?
          generate_notfication user_id: user.id , notifiable_type: 'WorkflowTransition', notifiable_id: @workflow_transition.id, notification_type: 'article_received', emmiter_id: current_user.id
        end
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
      @workflow_ids = WorkflowState.where(role_id: @role.id).collect(&:workflow_id)
      @workflow_state_ids = []
      for workflow_id in @workflow_ids
        @workflow_state_ids << WorkflowState.where(workflow_id: workflow_id).collect(&:id)
      end
      @articles = Article.where("workflow_state_id IN (?)", @workflow_state_ids.flatten.uniq).paginate(:page => params[:page], :per_page => 5)
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
    #@workflow_states = WorkflowState.where(role_id: current_user.current_role_id, start_point: 2).group_by(&:workflow_id).keys
    @workflows = Workflow.user_available_start_workflows(current_user)
    if @workflows.blank?
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
   # if !params[:workflow].blank?
    #  @workflow_state = WorkflowState.where(workflow_id: params[:workflow].to_i, start_point: 2, role_id: current_user.current_role_id).first
    #  if !@workflow_state.blank?
    #    @article.workflow_state_id = @workflow_state.id
    #  end
   # end
    @article.workflow_state_id = params[:workflow_state_id] if !params[:workflow_state_id].blank?
    @article.user_id = current_user.id
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
    @article.workflow_state_id = params[:workflow_state_id] if !params[:workflow_state_id].blank?
    respond_to do |format|
      if @article.update(article_params)
        if !params[:keyword].blank? || params[:keyword] == ''
          extract_keywords(@article, params[:keyword])
        end
        if !params[:other_title].blank? && params[:other_title] == 'true'
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
    params.each do |param|
      if param[0].include?('_title_type')
        for titling in @article.titlings
          titling.destroy
        end
      end
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
    params.require(:article).permit(:title, :abstract, :content, :url, :slug,:workflow_state_id, :retrieval_number, :dimensions, :notes, :description, :position)
  end
end
