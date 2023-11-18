class ProfilesController < ApplicationController
  before_action :set_profile,
                only: %i[show edit update destroy contributions profile_details cropper detach_profile]
  skip_before_action :verify_authenticity_toke, only: %i[create update]

  def detach_profile
    @profile.user_id = nil
    @profile.save
  end

  def mergerer; end

  def merge
    @profile_1 = Profile.find(params[:profile_1])
    @profile_2 = Profile.find(params[:profile_2])
    Profile.merge_profile(@profile_1, @profile_2)
    redirect_to '/profiles'
  end

  def cropper; end

  def profile_details; end

  def contributions; end

  def search
    users = User.search params[:q], star: true unless params[:q].blank?
    user_profiles = Profile.where(user_id: users.map(&:id)) 
    profiles = Profile.search params[:q], star: true unless params[:q].blank?
    @profiles = user_profiles.to_a + profiles.to_a rescue []
    resp = []
    for r in @profiles
      resp << if !r.user.blank?
                { 'title' => r.fullname + " (#{r.id}, #{r.user.email})", 'id' => r.id, 'user_id' => r.user.id }
              else
                { 'title' => r.fullname + " (#{r.id})", 'id' => r.id }
              end
    end
    render json: resp.to_json, callback: params['callback']
  end

  def search_in_users
    @profiles = Profile.search params[:q], star: true unless params[:q].blank?
    resp = []
    for r in @profiles
      resp << { 'title' => r.fullname + " (#{r.id})", 'id' => r.id, 'user_id' => r.user.id } unless r.user.blank?
    end
    render json: resp.to_json, callback: params['callback']
  end

  # GET /profiles
  # GET /profiles.json
  def index
    @profiles = Profile.all.order('surename asc').paginate(page: params[:page], per_page: 30)
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show; end

  # GET /profiles/new
  def new
    @profile = Profile.new
    render layout: 'layouts/devise'
  end

  # GET /profiles/1/edit
  def edit; end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = Profile.new(profile_params)
    @profile.user_id = current_user.id if @profile.email == current_user.email
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
    @profile.user_id = current_user.id if @profile.email == current_user.email
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
    params.require(:profile).permit(:email, :name, :surename, :user_id, :phone_number, :cellphone_number, :avatar,
                                    :crop_x, :crop_y, :crop_w, :crop_h, :signature, :dabir_personnel_id, :dabir_department_id)
  end
end
