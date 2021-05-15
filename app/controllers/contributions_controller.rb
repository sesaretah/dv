class ContributionsController < ApplicationController
  before_action :set_contribution, only: [:show, :remotesign, :edit, :update, :destroy]

  # GET /contributions
  # GET /contributions.json
  def index
    @contributions = Contribution.all
  end

  # GET /contributions/1
  # GET /contributions/1.json
  def show
  end

  def remotesign
    @contribution.sign = params[:sign]
    @contribution.save
  end

  # GET /contributions/new
  def new
    @contribution = Contribution.new
  end

  # GET /contributions/1/edit
  def edit
  end

  # POST /contributions
  # POST /contributions.json
  def create
    if !params[:profile_group_id].blank?
      @profile_group = ProfileGroup.find_by_id(params[:profile_group_id])
      if @profile_group
        for profile in @profile_group.profiles
          @contribution = Contribution.create(article_id: params[:contribution][:article_id], profile_id: profile.id, role_id: params[:contribution][:role_id], duty_id: params[:contribution][:duty_id])
        end
        @article = @contribution.article
        respond_to do |format|
          format.js
        end
      end
    else
      @contribution = Contribution.new(contribution_params)
      @article = @contribution.article
      respond_to do |format|
        if @contribution.save
          format.html { redirect_to @contribution, notice: "Contribution was successfully created." }
          format.json { render :show, status: :created, location: @contribution }
          format.js
        else
          format.html { render :new }
          format.json { render json: @contribution.errors, status: :unprocessable_entity }
          format.js
        end
      end
    end
  end

  # PATCH/PUT /contributions/1
  # PATCH/PUT /contributions/1.json
  def update
    respond_to do |format|
      if @contribution.update(contribution_params)
        format.html { redirect_to @contribution, notice: "Contribution was successfully updated." }
        format.json { render :show, status: :ok, location: @contribution }
      else
        format.html { render :edit }
        format.json { render json: @contribution.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /contributions/1
  # DELETE /contributions/1.json
  def destroy
    @article = @contribution.article
    @contribution.destroy
    respond_to do |format|
      format.html { redirect_to contributions_url, notice: "Contribution was successfully destroyed." }
      format.json { head :no_content }
      format.js
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_contribution
    @contribution = Contribution.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def contribution_params
    params.require(:contribution).permit(:article_id, :role_id, :duty_id, :profile_id, :sign)
  end
end
