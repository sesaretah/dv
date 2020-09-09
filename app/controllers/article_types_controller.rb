class ArticleTypesController < ApplicationController
  before_action :set_article_type, only: [:show, :edit, :update, :destroy]
  before_action :check_grant, only: [:new, :edit, :create,:update, :destroy]

  def mergerer

  end

  def merge
    @article_type_1 = ArticleType.find(params[:article_type_1])
    @article_type_2 = ArticleType.find(params[:article_type_2])
    ArticleType.merge_article_type(@article_type_1, @article_type_2)
    redirect_to '/article_types'
  end

  def search
    if !params[:q].blank?
      @article_types = ArticleType.search params[:q], :star => true
    end
    resp = []
    for r in @article_types
      resp << {'title' => r.title , 'id' => r.id}
    end
    render :json => resp.to_json, :callback => params['callback']
  end
  # GET /article_types
  # GET /article_types.json
  def index
    @article_types = ArticleType.all.order("title asc")
  end

  # GET /article_types/1
  # GET /article_types/1.json
  def show
  end

  # GET /article_types/new
  def new
    @article_type = ArticleType.new
  end

  # GET /article_types/1/edit
  def edit
  end

  # POST /article_types
  # POST /article_types.json
  def create
    @article_type = ArticleType.new(article_type_params)
    @article_type.user_id = current_user.id
    respond_to do |format|
      if @article_type.save
        format.html { redirect_to @article_type, notice: 'Article type was successfully created.' }
        format.json { render :show, status: :created, location: @article_type }
      else
        format.html { render :new }
        format.json { render json: @article_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /article_types/1
  # PATCH/PUT /article_types/1.json
  def update
    @article_type.user_id = current_user.id
    respond_to do |format|
      if @article_type.update(article_type_params)
        format.html { redirect_to @article_type, notice: 'Article type was successfully updated.' }
        format.json { render :show, status: :ok, location: @article_type }
      else
        format.html { render :edit }
        format.json { render json: @article_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /article_types/1
  # DELETE /article_types/1.json
  def destroy
    @article_type.destroy
    respond_to do |format|
      format.html { redirect_to article_types_url, notice: 'Article type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def check_grant
    if !grant_access("alter_article_types", current_user)
      head(403)
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_article_type
    @article_type = ArticleType.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def article_type_params
    params.require(:article_type).permit(:title, :description)
  end
end
