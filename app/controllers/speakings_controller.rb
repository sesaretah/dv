class SpeakingsController < ApplicationController
  before_action :set_speaking, only: [:show, :edit, :update, :destroy]

  def remotec
    @article = Article.find(params[:article_id])
    @language = Language.find(params[:language_id])
    Speaking.create(article_id: @article.id, language_id: @language.id)
  end

  def remoted
    @article = Article.find(params[:article_id])
    @language = Language.find(params[:language_id])
    @speaking = Speaking.where(article_id: @article.id, language_id: @language.id).first
    if !@speaking.blank?
      @speaking.destroy
    end
  end
  # GET /speakings
  # GET /speakings.json
  def index
    @speakings = Speaking.all
  end

  # GET /speakings/1
  # GET /speakings/1.json
  def show
  end

  # GET /speakings/new
  def new
    @speaking = Speaking.new
  end

  # GET /speakings/1/edit
  def edit
  end

  # POST /speakings
  # POST /speakings.json
  def create
    @speaking = Speaking.new(speaking_params)

    respond_to do |format|
      if @speaking.save
        format.html { redirect_to @speaking, notice: 'Speaking was successfully created.' }
        format.json { render :show, status: :created, location: @speaking }
      else
        format.html { render :new }
        format.json { render json: @speaking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /speakings/1
  # PATCH/PUT /speakings/1.json
  def update
    respond_to do |format|
      if @speaking.update(speaking_params)
        format.html { redirect_to @speaking, notice: 'Speaking was successfully updated.' }
        format.json { render :show, status: :ok, location: @speaking }
      else
        format.html { render :edit }
        format.json { render json: @speaking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /speakings/1
  # DELETE /speakings/1.json
  def destroy
    @speaking.destroy
    respond_to do |format|
      format.html { redirect_to speakings_url, notice: 'Speaking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_speaking
      @speaking = Speaking.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def speaking_params
      params.require(:speaking).permit(:language_id, :article_id)
    end
end
