class ArticleFormatsController < ApplicationController
  before_action :set_article_format, only: [:show, :edit, :update, :destroy]
  before_action :check_grant, only: [:new, :edit, :create,:update, :destroy]
  # GET /article_formats
  # GET /article_formats.json
  def mergerer

  end

  def merge
    @article_format_1 = ArticleFormat.find(params[:article_format_1])
    @article_format_2 = ArticleFormat.find(params[:article_format_2])
    ArticleFormat.merge_article_format(@article_format_1, @article_format_2)
    redirect_to '/article_formats'
  end

  def search
    if !params[:q].blank? 
      @article_formats = ArticleFormat.search params[:q], :star => true, :page =>1, :per_page => 100
    end
    resp = []
    for r in @article_formats
      resp << {'title' => r.title , 'id' => r.id}
    end
    render :json => resp.to_json, :callback => params['callback']
  end

  
  def index
    @article_formats = ArticleFormat.all.order("title asc")
  end

  # GET /article_formats/1
  # GET /article_formats/1.json
  def show
  end

  # GET /article_formats/new
  def new
    @article_format = ArticleFormat.new
  end

  # GET /article_formats/1/edit
  def edit
  end

  # POST /article_formats
  # POST /article_formats.json
  def create
    @article_format = ArticleFormat.new(article_format_params)
    @article_format.user_id = current_user.id
    respond_to do |format|
      if @article_format.save
        format.html { redirect_to @article_format, notice: 'Article format was successfully created.' }
        format.json { render :show, status: :created, location: @article_format }
      else
        format.html { render :new }
        format.json { render json: @article_format.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /article_formats/1
  # PATCH/PUT /article_formats/1.json
  def update
    @article_format.user_id = current_user.id
    respond_to do |format|
      if @article_format.update(article_format_params)
        format.html { redirect_to @article_format, notice: 'Article format was successfully updated.' }
        format.json { render :show, status: :ok, location: @article_format }
      else
        format.html { render :edit }
        format.json { render json: @article_format.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /article_formats/1
  # DELETE /article_formats/1.json
  def destroy
    @article_format.destroy
    respond_to do |format|
      format.html { redirect_to article_formats_url, notice: 'Article format was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def check_grant
    if !grant_access("alter_article_formats", current_user)
      head(403)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article_format
      @article_format = ArticleFormat.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_format_params
      params.require(:article_format).permit(:title, :description)
    end
end
