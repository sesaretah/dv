class AccessGroupsController < ApplicationController
  before_action :set_access_group, only: [:show, :edit, :update, :destroy]

  def search
    if !params[:q].blank?
      @access_groups = AccessGroup.search params[:q], :star => true
    end
    resp = []
    for r in @access_groups
      resp << { "title" => r.title, "id" => r.id }
    end
    render :json => resp.to_json, :callback => params["callback"]
  end

  # GET /access_groups
  # GET /access_groups.json
  def index
    @access_groups = AccessGroup.all
  end

  # GET /access_groups/1
  # GET /access_groups/1.json
  def show
  end

  # GET /access_groups/new
  def new
    @access_group = AccessGroup.new
  end

  # GET /access_groups/1/edit
  def edit
  end

  # POST /access_groups
  # POST /access_groups.json
  def create
    @access_group = AccessGroup.new(access_group_params)
    @access_group.user_id = current_user.id
    respond_to do |format|
      if @access_group.save
        format.html { redirect_to @access_group, notice: "Access group was successfully created." }
        format.json { render :show, status: :created, location: @access_group }
      else
        format.html { render :new }
        format.json { render json: @access_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /access_groups/1
  # PATCH/PUT /access_groups/1.json
  def update
    @access_group.user_id = current_user.id
    respond_to do |format|
      if @access_group.update(access_group_params)
        format.html { redirect_to @access_group, notice: "Access group was successfully updated." }
        format.json { render :show, status: :ok, location: @access_group }
      else
        format.html { render :edit }
        format.json { render json: @access_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /access_groups/1
  # DELETE /access_groups/1.json
  def destroy
    @access_group.destroy
    respond_to do |format|
      format.html { redirect_to access_groups_url, notice: "Access group was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_access_group
    @access_group = AccessGroup.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def access_group_params
    params.require(:access_group).permit(:title, :user_id)
  end
end
