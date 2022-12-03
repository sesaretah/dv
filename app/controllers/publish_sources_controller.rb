class PublishSourcesController < ApplicationController
  before_action :set_publish_source, only: [:show, :edit, :update, :destroy]

  def remotec
    @article = Article.find(params[:article_id]).update(publish_source_id: params[:publish_source_id])
  end

  def mergerer

  end

  def merge
    @publish_source_1 = PublishSource.find(params[:publish_source_1])
    @publish_source_2 = PublishSource.find(params[:publish_source_2])
    PublishSource.merge_publish_source(@publish_source_1, @publish_source_2)
    redirect_to '/publish_sources'
  end
  # GET /publish_sources
  # GET /publish_sources.json
  def index
    @publish_sources = PublishSource.all
  end

  # GET /publish_sources/1
  # GET /publish_sources/1.json
  def show
  end

  # GET /publish_sources/new
  def new
    @publish_source = PublishSource.new
  end

  # GET /publish_sources/1/edit
  def edit
  end

  # POST /publish_sources
  # POST /publish_sources.json
  def create
    @publish_source = PublishSource.new(publish_source_params)
    @publish_source.user_id = current_user.id
    respond_to do |format|
      if @publish_source.save
        format.html { redirect_to @publish_source, notice: 'Publish source was successfully created.' }
        format.json { render :show, status: :created, location: @publish_source }
      else
        format.html { render :new }
        format.json { render json: @publish_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /publish_sources/1
  # PATCH/PUT /publish_sources/1.json
  def update
    @publish_source.user_id = current_user.id
    respond_to do |format|
      if @publish_source.update(publish_source_params)
        format.html { redirect_to @publish_source, notice: 'Publish source was successfully updated.' }
        format.json { render :show, status: :ok, location: @publish_source }
      else
        format.html { render :edit }
        format.json { render json: @publish_source.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /publish_sources/1
  # DELETE /publish_sources/1.json
  def destroy
    @publish_source.destroy
    respond_to do |format|
      format.html { redirect_to publish_sources_url, notice: 'Publish source was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_publish_source
      @publish_source = PublishSource.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def publish_source_params
      params.require(:publish_source).permit(:title, :description, :publisher_id, :user_id)
    end
end
