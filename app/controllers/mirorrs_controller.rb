class MirorrsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_filter :authenticate_user!, :except => [:carry]

  def new
    @workflow = Workflow.find(params[:workflow_id])
    if !owner(@workflow, current_user) && !grant_access("edit_workflow", current_user)
      head(403)
    end
  end

  def show
    @mirorr = Mirorr.find(params[:id])
  end

  def index
    @workflow = Workflow.find(params[:workflow_id])
    @mirorrs = Mirorr.where("source_state in (?)", @workflow.workflow_states.pluck(:id).uniq).order("source_state asc")
  end

  def create
    mirorr = Mirorr.where(source_state: params[:mirorr][:source_state]).first
    if mirorr.blank?
      mirorr = Mirorr.create(carrier_params)
    else
      mirorr.update(carrier_params)
    end
    @workflow = Workflow.find(mirorr.source_state)
    @mirorrs = Mirorr.where("source_state in (?)", @workflow.workflow_states.pluck(:id).uniq).order("source_state asc")
  end

  def destroy
    @mirorr = Mirorr.find(params[:id])
    @workflow = Workflow.find(@mirorr.source_state)
    @mirorrs = Mirorr.where("source_state in (?)", @workflow.workflow_states.pluck(:id).uniq).order("source_state asc")
    if !@mirorr.blank?
      @mirorr.destroy
    end
  end

  def carrier_params
    params.require(:mirorr).permit(:user_id, :source_state, :target_state)
  end
end
