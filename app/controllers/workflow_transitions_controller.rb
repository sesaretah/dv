class WorkflowTransitionsController < ApplicationController
  before_action :set_workflow_transition, only: [:show, :edit, :update, :destroy]

  # GET /workflow_transitions
  # GET /workflow_transitions.json
  def index
    @workflow_transitions = WorkflowTransition.all
  end

  # GET /workflow_transitions/1
  # GET /workflow_transitions/1.json
  def show
  end

  # GET /workflow_transitions/new
  def new
    @workflow_transition = WorkflowTransition.new
  end

  # GET /workflow_transitions/1/edit
  def edit
  end

  # POST /workflow_transitions
  # POST /workflow_transitions.json
  def create
    @workflow_transition = WorkflowTransition.new(workflow_transition_params)

    respond_to do |format|
      if @workflow_transition.save
        format.html { redirect_to @workflow_transition, notice: 'Workflow transition was successfully created.' }
        format.json { render :show, status: :created, location: @workflow_transition }
      else
        format.html { render :new }
        format.json { render json: @workflow_transition.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workflow_transitions/1
  # PATCH/PUT /workflow_transitions/1.json
  def update
    respond_to do |format|
      if @workflow_transition.update(workflow_transition_params)
        format.html { redirect_to @workflow_transition, notice: 'Workflow transition was successfully updated.' }
        format.json { render :show, status: :ok, location: @workflow_transition }
      else
        format.html { render :edit }
        format.json { render json: @workflow_transition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workflow_transitions/1
  # DELETE /workflow_transitions/1.json
  def destroy
    @workflow_transition.destroy
    respond_to do |format|
      format.html { redirect_to workflow_transitions_url, notice: 'Workflow transition was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workflow_transition
      @workflow_transition = WorkflowTransition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def workflow_transition_params
      params.require(:workflow_transition).permit(:workflow_id, :from_state_id, :to_state_id, :message, :user_id, :role_id, :transition_type, :article_id)
    end
end
