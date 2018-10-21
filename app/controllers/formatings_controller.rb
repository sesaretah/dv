class FormatingsController < ApplicationController
  before_action :set_formating, only: [:show, :edit, :update, :destroy]
  def remotec
    @article = Article.find(params[:article_id])
    @article_format = ArticleFormat.find(params[:article_format_id])
    Formating.create(article_id: @article.id, article_format_id: @article_format.id)
  end

  def remoted
    @article = Article.find(params[:article_id])
    @article_format = ArticleType.find(params[:article_format_id])
    @formating = Formating.where(article_id: @article.id, article_format_id: @article_format.id).first
    if !@formating.blank?
      @formating.destroy
    end
  end
  # GET /formatings
  # GET /formatings.json
  def index
    @formatings = Formating.all
  end

  # GET /formatings/1
  # GET /formatings/1.json
  def show
  end

  # GET /formatings/new
  def new
    @formating = Formating.new
  end

  # GET /formatings/1/edit
  def edit
  end

  # POST /formatings
  # POST /formatings.json
  def create
    @formating = Formating.new(formating_params)

    respond_to do |format|
      if @formating.save
        format.html { redirect_to @formating, notice: 'Formating was successfully created.' }
        format.json { render :show, status: :created, location: @formating }
      else
        format.html { render :new }
        format.json { render json: @formating.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /formatings/1
  # PATCH/PUT /formatings/1.json
  def update
    respond_to do |format|
      if @formating.update(formating_params)
        format.html { redirect_to @formating, notice: 'Formating was successfully updated.' }
        format.json { render :show, status: :ok, location: @formating }
      else
        format.html { render :edit }
        format.json { render json: @formating.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /formatings/1
  # DELETE /formatings/1.json
  def destroy
    @formating.destroy
    respond_to do |format|
      format.html { redirect_to formatings_url, notice: 'Formating was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_formating
      @formating = Formating.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def formating_params
      params.require(:formating).permit(:article_format_id, :article_id)
    end
end
