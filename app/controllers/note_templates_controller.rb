class NoteTemplatesController < ApplicationController
  before_action :set_note_template, only: [:show, :edit, :update, :destroy]

  # GET /note_templates
  # GET /note_templates.json
  def index
    @note_templates = NoteTemplate.all
  end

  # GET /note_templates/1
  # GET /note_templates/1.json
  def show
  end

  # GET /note_templates/new
  def new
    @note_template = NoteTemplate.new
  end

  # GET /note_templates/1/edit
  def edit
  end

  # POST /note_templates
  # POST /note_templates.json
  def create
    @note_template = NoteTemplate.new(note_template_params)
    @note_template.user_id = current_user.id
    respond_to do |format|
      if @note_template.save
        format.html { redirect_to '/note_templates', notice: 'Note template was successfully created.' }
        format.json { render :show, status: :created, location: @note_template }
      else
        format.html { render :new }
        format.json { render json: @note_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /note_templates/1
  # PATCH/PUT /note_templates/1.json
  def update
    respond_to do |format|
      if  @note_template.user_id == current_user.id && @note_template.update(note_template_params)
        format.html { redirect_to @note_template, notice: 'Note template was successfully updated.' }
        format.json { render :show, status: :ok, location: @note_template }
      else
        format.html { render :edit }
        format.json { render json: @note_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /note_templates/1
  # DELETE /note_templates/1.json
  def destroy
    if  @note_template.user_id == current_user.id && @note_template.destroy
    respond_to do |format|
      format.html { redirect_to note_templates_url, notice: 'Note template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note_template
      @note_template = NoteTemplate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def note_template_params
      params.require(:note_template).permit(:title, :user_id)
    end
end
