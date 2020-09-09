class ArticleAreasController < ApplicationController
  before_action :set_article_area, only: [:show, :edit, :update, :destroy]
  before_action :check_grant, only: [:new, :edit, :create,:update, :destroy]
  
  def mergerer

  end

  def merge
    @article_area_1 = ArticleArea.find(params[:article_area_1])
    @article_area_2 = ArticleArea.find(params[:article_area_2])
    ArticleArea.merge_article_area(@article_area_1, @article_area_2)
    redirect_to '/article_areas'
  end

  def search
    if !params[:q].blank? 
      @article_areas = ArticleArea.search params[:q], :star => true, :page =>1, :per_page => 100
    end
    resp = []
    for r in @article_areas
      resp << {'title' => r.title , 'id' => r.id}
    end
    render :json => resp.to_json, :callback => params['callback']
  end
  # GET /article_areas
  # GET /article_areas.json
  def index
    @article_areas = ArticleArea.all.order("title asc").paginate(:page => params[:page], :per_page => 30)
  end

  # GET /article_areas/1
  # GET /article_areas/1.json
  def show
  end

  # GET /article_areas/new
  def new
    @article_area = ArticleArea.new
  end

  # GET /article_areas/1/edit
  def edit
  end

  # POST /article_areas
  # POST /article_areas.json
  def create
    @article_area = ArticleArea.new(article_area_params)
    @article_area.user_id = current_user.id
    respond_to do |format|
      if @article_area.save
        format.html { redirect_to @article_area, notice: 'Article area was successfully created.' }
        format.json { render :show, status: :created, location: @article_area }
      else
        format.html { render :new }
        format.json { render json: @article_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /article_areas/1
  # PATCH/PUT /article_areas/1.json
  def update
    @article_area.user_id = current_user.id
    respond_to do |format|
      if @article_area.update(article_area_params)
        format.html { redirect_to @article_area, notice: 'Article area was successfully updated.' }
        format.json { render :show, status: :ok, location: @article_area }
      else
        format.html { render :edit }
        format.json { render json: @article_area.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /article_areas/1
  # DELETE /article_areas/1.json
  def destroy
    @article_area.destroy
    respond_to do |format|
      format.html { redirect_to article_areas_url, notice: 'Article area was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def check_grant
    if !grant_access("alter_article_areas", current_user)
      head(403)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article_area
      @article_area = ArticleArea.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_area_params
      params.require(:article_area).permit(:title, :description)
    end
end
