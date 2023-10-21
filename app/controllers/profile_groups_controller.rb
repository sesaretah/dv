class ProfileGroupsController < ApplicationController
  before_action :set_profile_group, only: [:show, :edit, :update, :destroy]

  # GET /profile_groups
  # GET /profile_groups.json
  def index
    @profile_groups = ProfileGroup.all
  end

  # GET /profile_groups/1
  # GET /profile_groups/1.json
  def show
  end

  # GET /profile_groups/new
  def new
    @profile_group = ProfileGroup.new
  end

  # GET /profile_groups/1/edit
  def edit
  end

  # POST /profile_groups
  # POST /profile_groups.json
  def create
    @profile_group = ProfileGroup.new(profile_group_params)
    @profile_group.user_id = current_user.id
    respond_to do |format|
      if @profile_group.save
        format.html { redirect_to @profile_group, notice: 'Profile group was successfully created.' }
        format.json { render :show, status: :created, location: @profile_group }
      else
        format.html { render :new }
        format.json { render json: @profile_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profile_groups/1
  # PATCH/PUT /profile_groups/1.json
  def update
    respond_to do |format|
        @profile_group.user_id = current_user.id
      if @profile_group.update(profile_group_params)
        format.html { redirect_to @profile_group, notice: 'Profile group was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile_group }
      else
        format.html { render :edit }
        format.json { render json: @profile_group.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profile_groups/1
  # DELETE /profile_groups/1.json
  def destroy
    @profile_group.destroy
    respond_to do |format|
      format.html { redirect_to profile_groups_url, notice: 'Profile group was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile_group
      @profile_group = ProfileGroup.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_group_params
      params.require(:profile_group).permit(:title, :description, :workflow_id)
    end
end
