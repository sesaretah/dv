class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy, :contributions, :profile_details, :cropper]

  def cropper

  end
  def profile_details

  end
  def contributions

  end

  def search
    if !params[:q].blank?
      @profiles = Profile.search params[:q], :star => true
    end
    resp = []
    for r in @profiles
      if !r.user.blank?
        resp << {'title' => r.fullname , 'id' => r.id, 'user_id' => r.user.id}
      end
    end
    render :json => resp.to_json, :callback => params['callback']
  end
  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
  end

  # GET /profiles/new
  def new
    @profile = Profile.new
    render layout: 'layouts/devise'
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)
    if @profile.email == current_user.email
      @profile.user_id = current_user.id
    end
    respond_to do |format|
      if @profile.save
        if params[:profile][:avatar].blank?
          format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        else
          format.html { redirect_to "/profiles/cropper/#{@profile.id}", notice: 'Profile was successfully updated.' }
        end
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    if @profile.email == current_user.email
      @profile.user_id = current_user.id
    end
    respond_to do |format|
      if @profile.update(profile_params)
        if params[:profile][:avatar].blank?
          format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        else
          format.html { redirect_to "/profiles/cropper/#{@profile.id}", notice: 'Profile was successfully updated.' }
        end
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to profiles_url, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:name, :surename, :user_id, :phone_number, :cellphone_number, :avatar, :crop_x, :crop_y, :crop_w, :crop_h)
    end
end
