class ProfileGroupingsController < ApplicationController
    skip_before_filter :verify_authenticity_token 
    def new
        @profile_grouping = ProfileGrouping.new
    end

    def create
        @profile_grouping = ProfileGrouping.new
        @profile_grouping.profile_group_id = params[:profile_group_id]
        @profile_grouping.profile_id = params[:profile_id]
        @profile_grouping.user_id = current_user.id
        respond_to do |format|
            if @profile_grouping.save
              format.html { redirect_to @profile_grouping.profile_group, notice: 'Language was successfully created.' }
            else
              format.html { render :new }
            end
          end
    end

    def delete
        @profile_grouping = ProfileGrouping.where(profile_group_id: params[:profile_group_id], profile_id: params[:profile_id]).first
        if @profile_grouping
            @profile_group = @profile_grouping.profile_group
            @profile_grouping.destroy
            redirect_to @profile_group
        end
    end

    def profile_grouping_params
        params.permit!#require(:profile_grouping).permit(:profile_id, :profile_group_id, :user_id)
    end
end
