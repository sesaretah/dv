class ContentTemplatesController < ApplicationController
  before_action :set_content_template, only: [:show, :edit, :update, :destroy]
  before_action :check_grant, only: [:new, :edit, :create,:update, :destroy]

  # GET /content_templates
  # GET /content_templates.json
  def index
    @content_templates = ContentTemplate.all.order("title asc")
  end

  # GET /content_templates/1
  # GET /content_templates/1.json
  def show
  end

  # GET /content_templates/new
  def new
    @content_template = ContentTemplate.new
  end

  # GET /content_templates/1/edit
  def edit
  end

  # POST /content_templates
  # POST /content_templates.json
  def create
    @content_template = ContentTemplate.new(content_template_params)
    @content_template.user_id = current_user.id
    respond_to do |format|
      if @content_template.save
        format.html { redirect_to @content_template, notice: 'Content template was successfully created.' }
        format.json { render :show, status: :created, location: @content_template }
      else
        format.html { render :new }
        format.json { render json: @content_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /content_templates/1
  # PATCH/PUT /content_templates/1.json
  def update
    @content_template.user_id = current_user.id
    respond_to do |format|
      if @content_template.update(content_template_params)
        format.html { redirect_to @content_template, notice: 'Content template was successfully updated.' }
        format.json { render :show, status: :ok, location: @content_template }
      else
        format.html { render :edit }
        format.json { render json: @content_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /content_templates/1
  # DELETE /content_templates/1.json
  def destroy
    @content_template.destroy
    respond_to do |format|
      format.html { redirect_to content_templates_url, notice: 'Content template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def check_grant
    if !grant_access("alter_content_templates", current_user)
      head(403)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_content_template
      @content_template = ContentTemplate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def content_template_params
      params.require(:content_template).permit(:title, :content, :user_id)
    end
end
