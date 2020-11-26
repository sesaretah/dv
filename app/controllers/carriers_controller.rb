class CarriersController < ApplicationController
    skip_before_action :verify_authenticity_token

    def new
        @workflow = Workflow.find(params[:workflow_id])
        if !owner(@workflow, current_user) && !grant_access('edit_workflow', current_user)
            head(403)
        end
       
    end


    def carry
        p '%%%%%%%%%%%%'
        @carrier = Carrier.first
        CarrierWorker.perform_async(params[:id])
    end
    
    def show
        @carrier = Carrier.find(params[:id])
    end
    
    def index
        @workflow = Workflow.find(params[:workflow_id])
        @carriers = Carrier.where('source_workflow_state_id in (?)', @workflow.workflow_states.pluck(:id).uniq).order('source_workflow_state_id asc')
    end
    
    def create
        carrier = Carrier.where(source_workflow_state_id: params[:carrier][:source_workflow_state_id]).first
        if carrier.blank?
            carrier = Carrier.create(carrier_params)
        else
            carrier.update(carrier_params)
        end
        @workflow = carrier.source_state.workflow
        @carriers = Carrier.where('source_workflow_state_id in (?)', @workflow.workflow_states.pluck(:id).uniq).order('source_workflow_state_id asc')
    end
  
    def destroy
      @carrier = Carrier.find(params[:id])
      @workflow = @carrier.source_state.workflow
      @carriers = Carrier.where('source_workflow_state_id in (?)', @workflow.workflow_states.pluck(:id).uniq).order('source_workflow_state_id asc')
      if !@carrier.blank?
        @carrier.destroy
      end
    end

    def carrier_params
        params.require(:carrier).permit(:user_id,:source_workflow_state_id, :target_workflow_state_id, :trials, :voting_condition, :timer)
    end
end
