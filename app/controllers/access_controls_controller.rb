class AccessControlsController < ApplicationController
  before_action :set_access_control, only: [:show, :edit, :update, :destroy]

  # GET /access_controls
  # GET /access_controls.json
  def index
    if !grant_access("alter_roles", current_user)
      head(403)
    end
    @access_controls = AccessControl.all
  end

  # GET /access_controls/1
  # GET /access_controls/1.json
  def show
  end

  # GET /access_controls/new
  def new
    if !grant_access("alter_roles", current_user)
      head(403)
    end
    @access_control = AccessControl.new
  end

  # GET /access_controls/1/edit
  def edit
    if !grant_access("alter_roles", current_user)
      head(403)
    end
  end

  # POST /access_controls
  # POST /access_controls.json
  def create
    @access_control = AccessControl.new(access_control_params)

    respond_to do |format|
      if @access_control.save
        format.html { redirect_to @access_control, notice: 'Access control was successfully created.' }
        format.json { render :show, status: :created, location: @access_control }
      else
        format.html { render :new }
        format.json { render json: @access_control.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /access_controls/1
  # PATCH/PUT /access_controls/1.json
  def update
    respond_to do |format|
      if @access_control.update(access_control_params)
        format.html { redirect_to @access_control, notice: 'Access control was successfully updated.' }
        format.json { render :show, status: :ok, location: @access_control }
      else
        format.html { render :edit }
        format.json { render json: @access_control.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /access_controls/1
  # DELETE /access_controls/1.json
  def destroy
    if !grant_access("alter_roles", current_user)
      head(403)
    end
    @access_control.destroy
    respond_to do |format|
      format.html { redirect_to access_controls_url, notice: 'Access control was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_access_control
      @access_control = AccessControl.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def access_control_params
      params.require(:access_control).permit(:user_id, :role_id, :view_unrelated_articles, :view_article_logs, :view_workflow_transactions, :create_workflow, :alter_article_areas, :alter_article_events, :alter_article_formats, :alter_article_relation_types, :alter_article_sources, :alter_article_types, :alter_keywords, :alter_languages, :alter_profiles, :alter_roles, :alter_duties, :alter_title_types, :alter_content_templates, :alter_section_items, :alter_publishers, :alter_locations, :alter_publish_sources, :alter_access_groups, :alter_profile_groups, :edit_workflow, :edit_roles, :alter_assignments, :edit_assignments)
    end
end
