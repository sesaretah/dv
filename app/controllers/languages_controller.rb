class LanguagesController < ApplicationController
  before_action :set_language, only: [:show, :edit, :update, :destroy]


  # GET /languages
  # GET /languages.json
  def index
    @languages = Language.all
  end

  # GET /languages/1
  # GET /languages/1.json
  def show
  end

  # GET /languages/new
  def new
    if !grant_access("alter_languages", current_user)
      head(403)
    end
    @language = Language.new
  end

  # GET /languages/1/edit
  def edit
    if !grant_access("alter_languages", current_user)
      head(403)
    end
  end

  # POST /languages
  # POST /languages.json
  def create
    if !grant_access("alter_languages", current_user)
      head(403)
    end
    @language = Language.new(language_params)
    @language.user_id = current_user.id
    respond_to do |format|
      if @language.save
        format.html { redirect_to @language, notice: 'Language was successfully created.' }
        format.json { render :show, status: :created, location: @language }
      else
        format.html { render :new }
        format.json { render json: @language.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /languages/1
  # PATCH/PUT /languages/1.json
  def update
    if !grant_access("alter_languages", current_user)
      head(403)
    end
    @language.user_id = current_user.id
    respond_to do |format|
      if @language.update(language_params)
        format.html { redirect_to @language, notice: 'Language was successfully updated.' }
        format.json { render :show, status: :ok, location: @language }
      else
        format.html { render :edit }
        format.json { render json: @language.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /languages/1
  # DELETE /languages/1.json
  def destroy
    if !grant_access("alter_languages", current_user)
      head(403)
    end
    @language.destroy
    respond_to do |format|
      format.html { redirect_to languages_url, notice: 'Language was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_language
      @language = Language.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def language_params
      params.require(:language).permit(:title, :description)
    end
end
