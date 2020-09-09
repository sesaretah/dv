class ArticleSourcesController < ApplicationController
  before_action :set_article_source, only: [:show, :edit, :update, :destroy]
  before_action :check_grant, only: [:new, :edit, :create,:update, :destroy]


  def mergerer

  end

  def merge
    @article_source_1 = ArticleSource.find(params[:article_source_1])
    @article_source_2 = ArticleSource.find(params[:article_source_2])
    ArticleSource.merge_article_source(@article_source_1, @article_source_2)
    redirect_to '/article_sources'
  end
  
  def search
    if !params[:q].blank?
      @article_sources = ArticleSource.search params[:q], :star => true
    end
    resp = []
    for r in @article_sources
      resp << {'title' => r.title , 'id' => r.id}
    end
    render :json => resp.to_json, :callback => params['callback']
  end
  # GET /article_sources
  # GET /article_sources.json
  def index
    @article_sources = ArticleSource.all.order("title asc")
  end

  # GET /article_sources/1
  # GET /article_sources/1.json
  def show
  end

  # GET /article_sources/new
  def new
    @article_source = ArticleSource.new
  end

  # GET /article_sources/1/edit
  def edit
  end

  # POST /article_sources
  # POST /article_sources.json
  def create
    @article_source = ArticleSource.new(article_source_params)
    @article_source.user_id = current_user.id
    respond_to do |format|
      if @article_source.save
        format.html { redirect_to @article_source, notice: 'Article source was successfully created.' }
        format.json { render :show, status: :created, location: @article_source }
      else
        format.html { render :new }
        format.json { render json: @article_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /article_sources/1
  # PATCH/PUT /article_sources/1.json
  def update
    @article_source.user_id = current_user.id
    respond_to do |format|
      if @article_source.update(article_source_params)
        format.html { redirect_to @article_source, notice: 'Article source was successfully updated.' }
        format.json { render :show, status: :ok, location: @article_source }
      else
        format.html { render :edit }
        format.json { render json: @article_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /article_sources/1
  # DELETE /article_sources/1.json
  def destroy
    @article_source.destroy
    respond_to do |format|
      format.html { redirect_to article_sources_url, notice: 'Article source was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def check_grant
    if !grant_access("alter_article_sources", current_user)
      head(403)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article_source
      @article_source = ArticleSource.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_source_params
      params.require(:article_source).permit(:title, :description)
    end
end
