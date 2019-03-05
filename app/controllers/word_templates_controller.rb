class WordTemplatesController < ApplicationController
  before_action :set_word_template, only: [:show, :edit, :update, :destroy]

  # GET /word_templates
  # GET /word_templates.json
  def index
    @word_templates = WordTemplate.all
  end

  # GET /word_templates/1
  # GET /word_templates/1.json
  def show
  end

  # GET /word_templates/new
  def new
    @word_template = WordTemplate.new
  end

  # GET /word_templates/1/edit
  def edit
  end

  # POST /word_templates
  # POST /word_templates.json
  def create
    @word_template = WordTemplate.new(word_template_params)
    @word_template.user_id = current_user.id
    respond_to do |format|
      if @word_template.save
        format.html { redirect_to @word_template, notice: 'Word template was successfully created.' }
        format.json { render :show, status: :created, location: @word_template }
      else
        format.html { render :new }
        format.json { render json: @word_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /word_templates/1
  # PATCH/PUT /word_templates/1.json
  def update
    respond_to do |format|
      if @word_template.update(word_template_params)
        format.html { redirect_to @word_template, notice: 'Word template was successfully updated.' }
        format.json { render :show, status: :ok, location: @word_template }
      else
        format.html { render :edit }
        format.json { render json: @word_template.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /word_templates/1
  # DELETE /word_templates/1.json
  def destroy
    @word_template.destroy
    respond_to do |format|
      format.html { redirect_to word_templates_url, notice: 'Word template was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word_template
      @word_template = WordTemplate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def word_template_params
      params.require(:word_template).permit(:title, :workflow_id, :document)
    end
end
