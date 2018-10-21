class TypingsController < ApplicationController
  before_action :set_typing, only: [:show, :edit, :update, :destroy]

  def remotec
    @article = Article.find(params[:article_id])
    @article_type = ArticleType.find(params[:article_type_id])
    Typing.create(article_id: @article.id, article_type_id: @article_type.id)
  end

  def remoted
    @article = Article.find(params[:article_id])
    @article_type = ArticleType.find(params[:article_type_id])
    @typing = Typing.where(article_id: @article.id, article_type_id: @article_type.id).first
    if !@typing.blank?
      @typing.destroy
    end
  end
  # GET /typings
  # GET /typings.json
  def index
    @typings = Typing.all
  end

  # GET /typings/1
  # GET /typings/1.json
  def show
  end

  # GET /typings/new
  def new
    @typing = Typing.new
  end

  # GET /typings/1/edit
  def edit
  end

  # POST /typings
  # POST /typings.json
  def create
    @typing = Typing.new(typing_params)

    respond_to do |format|
      if @typing.save
        format.html { redirect_to @typing, notice: 'Typing was successfully created.' }
        format.json { render :show, status: :created, location: @typing }
      else
        format.html { render :new }
        format.json { render json: @typing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /typings/1
  # PATCH/PUT /typings/1.json
  def update
    respond_to do |format|
      if @typing.update(typing_params)
        format.html { redirect_to @typing, notice: 'Typing was successfully updated.' }
        format.json { render :show, status: :ok, location: @typing }
      else
        format.html { render :edit }
        format.json { render json: @typing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /typings/1
  # DELETE /typings/1.json
  def destroy
    @typing.destroy
    respond_to do |format|
      format.html { redirect_to typings_url, notice: 'Typing was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_typing
      @typing = Typing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def typing_params
      params.require(:typing).permit(:article_type_id, :article_id)
    end
end
