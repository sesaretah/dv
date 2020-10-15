class WorkflowsController < ApplicationController
  before_action :set_workflow, only: [:show, :edit, :update, :destroy,:related_articles, :role_accesses, :change_role_access]

  def change_role_access
    workflow_role_access = WorkflowRoleAccess.where(workflow_id: @workflow.id, role_id: params[:role_id]).first
    if workflow_role_access.blank?
      workflow_role_access = WorkflowRoleAccess.create(workflow_id: @workflow.id, role_id: params[:role_id])
    end
    if params[:access] == 'own_article_traceable'
      workflow_role_access.own_article_traceable = params[:value]
    end

    if params[:access] == 'other_articles_traceable'
      workflow_role_access.other_articles_traceable = params[:value]
    end

    workflow_role_access.save
  end

  def role_accesses
    
  end

  def related_articles
    @workflow_state = WorkflowState.where(workflow_id: @workflow.id, node_id: params[:node_id]).first
    @articles = Article.where(workflow_state_id: @workflow_state.id).limit(5)
    resp = []
    for a in @articles
      resp << {'title' => a.title.truncate(30), 'abstract' => a.abstract, 'id' => a.id}
    end
    render :json => resp.to_json, :callback => params['callback']
  end
  # GET /workflows
  # GET /workflows.json
  def index
    @workflows = Workflow.all
  end

  # GET /workflows/1
  # GET /workflows/1.json
  def show
  end

  # GET /workflows/new
  def new
    if !grant_access("create_workflow", current_user)
      head(403)
    end
    @workflow = Workflow.new
  end

  # GET /workflows/1/edit
  def edit
    if !owner(@workflow, current_user) && !grant_access('edit_workflow', current_user)
      head(403)
    end
    @edges = @workflow.prepare_edges
    @nodes = JSON.parse @workflow.nodes
  end

  # POST /workflows
  # POST /workflows.json
  def create
    if !grant_access("create_workflow", current_user)
      head(403)
    end
    @workflow = Workflow.new(workflow_params)
    @workflow.user_id = current_user.id
    @nodes = JSON.parse params[:workflow][:nodes]
    @trimed_nodes = []
    for node in @nodes
      if !node['title'].blank?
        @trimed_nodes << node
        if node['start_point'] == 2
          @workflow.start_node_id = node['id']
        end
      end
    end
    @workflow.nodes = @trimed_nodes.to_json
    respond_to do |format|
      if @workflow.save
        for node in @nodes
          if !node['title'].blank?
            WorkflowState.create(workflow_id: @workflow.id, title: node['title'], node_id: node['id'], editable: node['editable'], refundable: node['refundable'], commentable: node['commentable'], start_point: node['start_point'], end_point: node['end_point'],  publishable: node['publishable'] ,role_id: node['role'])
          end
        end
        format.html { redirect_to @workflow, notice: 'Workflow was successfully created.' }
        format.json { render :show, status: :created, location: @workflow }
      else
        format.html { render :new }
        format.json { render json: @workflow.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workflows/1
  # PATCH/PUT /workflows/1.json
  def update
    if !owner(@workflow, current_user)  && !grant_access('edit_workflow', current_user)
      head(403)
    end
    #@workflow.user_id = current_user.id
    @nodes = JSON.parse params[:workflow][:nodes]
    @trimed_nodes = []
    for node in @nodes
      if !node['title'].blank?
        if node['start_point'] == '2'
          @workflow.start_node_id = node['id']
        end
        @trimed_nodes << node
        @state =  WorkflowState.where(workflow_id: @workflow.id, node_id: node['id']).first
        if @state.blank?
          WorkflowState.create(workflow_id: @workflow.id, title: node['title'], node_id: node['id'], editable: node['editable'], refundable: node['refundable'], commentable: node['commentable'], start_point: node['start_point'], end_point: node['end_point'], role_id: node['role'])
        else
          @state.title = node['title']
          @state.editable = node['editable']
          @state.refundable = node['refundable']
          @state.commentable = node['commentable']
          @state.start_point = node['start_point']
          @state.end_point = node['end_point']
          @state.publishable = node['publishable']
          @state.role_id = node['role']
          @state.votable = node['votable']
          @state.save
        end
      end
    end
    @workflow.nodes = @trimed_nodes.to_json
    respond_to do |format|
      if @workflow.update(workflow_params)
        format.html { redirect_to @workflow, notice: 'Workflow was successfully updated.' }
        format.json { render :show, status: :ok, location: @workflow }
      else
        format.html { render :edit }
        format.json { render json: @workflow.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workflows/1
  # DELETE /workflows/1.json
  def destroy
    if !owner(@workflow, current_user)
      head(403)
    end
    @workflow.destroy
    respond_to do |format|
      format.html { redirect_to workflows_url, notice: 'Workflow was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workflow
      @workflow = Workflow.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def workflow_params
      params.require(:workflow).permit(:title, :description, :user_id, :graph_data, :nodes, :edges, :start_node_id)
    end
end
