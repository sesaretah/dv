class ArticleRelationTypesController < ApplicationController
  before_action :set_article_relation_type, only: [:show, :edit, :update, :destroy]
  before_action :check_grant, only: [:new, :edit, :create,:update, :destroy]

  def mergerer

  end

  def merge
    @article_relation_type_1 = ArticleRelationType.find(params[:article_relation_type_1])
    @article_relation_type_2 = ArticleRelationType.find(params[:article_relation_type_2])
    ArticleRelationType.merge_article_relation_type(@article_relation_type_1, @article_relation_type_2)
    redirect_to '/article_relation_types'
  end

  
  def search
    if !params[:q].blank?
      @article_relation_types = ArticleRelationType.search params[:q], :star => true
    end
    resp = []
    for k in @article_relation_types
      resp << {'title' => k.title, 'id' => k.id}
    end
    render :json => resp.to_json, :callback => params['callback']
  end
  # GET /article_relation_types
  # GET /article_relation_types.json
  def index
    @article_relation_types = ArticleRelationType.all.order("title asc")
  end

  # GET /article_relation_types/1
  # GET /article_relation_types/1.json
  def show
  end

  # GET /article_relation_types/new
  def new
    @article_relation_type = ArticleRelationType.new
  end

  # GET /article_relation_types/1/edit
  def edit
  end

  # POST /article_relation_types
  # POST /article_relation_types.json
  def create
    @article_relation_type = ArticleRelationType.new(article_relation_type_params)
    @article_relation_type.user_id = current_user.id
    respond_to do |format|
      if @article_relation_type.save
        format.html { redirect_to @article_relation_type, notice: 'Article relation type was successfully created.' }
        format.json { render :show, status: :created, location: @article_relation_type }
      else
        format.html { render :new }
        format.json { render json: @article_relation_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /article_relation_types/1
  # PATCH/PUT /article_relation_types/1.json
  def update
    @article_relation_type.user_id = current_user.id
    respond_to do |format|
      if @article_relation_type.update(article_relation_type_params)
        format.html { redirect_to @article_relation_type, notice: 'Article relation type was successfully updated.' }
        format.json { render :show, status: :ok, location: @article_relation_type }
      else
        format.html { render :edit }
        format.json { render json: @article_relation_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /article_relation_types/1
  # DELETE /article_relation_types/1.json
  def destroy
    @article_relation_type.destroy
    respond_to do |format|
      format.html { redirect_to article_relation_types_url, notice: 'Article relation type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def check_grant
    if !grant_access("alter_article_relation_types", current_user)
      head(403)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article_relation_type
      @article_relation_type = ArticleRelationType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_relation_type_params
      params.require(:article_relation_type).permit(:title, :description, :reverse_relation_id)
    end
end
