class RoleAccessesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    @role_access = RoleAccess.create(role_id: params[:role_id], access_group_id: params[:access_group_id])
  end

  def destroy
    @role_access = RoleAccess.where(role_id: params[:role_id], access_group_id: params[:access_group_id]).first
    if !@role_access.blank?
      @role_access.destroy
    end
  end
end
