class StatePagesController < ApplicationController
  def show
    @state_page = StatePage.where(uuid: params[:uuid]).first
  end

  def new
    @workflow = Workflow.find(params[:workflow_id])
  end

  def index
    @workflow = Workflow.find(params[:id])
    @state_pages = StatePage.where("workflow_state_id in (?)", @workflow.workflow_states.pluck(:id))
  end

  def create
    state_page = StatePage.where(workflow_state_id: params[:state_page][:workflow_state_id]).first
    if state_page.blank?
      state_page = StatePage.create(state_page_params)
    else
      state_page.update(state_page_params)
    end
    @workflow = state_page.workflow_state.workflow
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
    params.require(:state_page).permit(:workflow_state_id, :item_title, :item_titlings, :item_abstract, :item_url, :item_keywords, :item_datings, :item_typings, :item_speakings, :item_formatings, :item_contributions, :item_kinships, :item_originatings, :item_content, :item_upload)
  end
end
