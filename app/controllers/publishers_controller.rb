class PublishersController < ApplicationController
  before_action :set_publisher, only: [:show, :edit, :update, :destroy, :publish_sources]


  def mergerer

  end

  def merge
    @publisher_1 = Publisher.find(params[:publisher_1])
    @publisher_2 = Publisher.find(params[:publisher_2])
    Publisher.merge_publisher(@publisher_1, @publisher_2)
    redirect_to '/publishers'
  end
  
  def publish_sources
    @publish_sources = @publisher.publish_sources
    resp = []
    for r in @publish_sources
      resp << {'title' => r.title, 'id' => r.id}
    end
    render :json => resp.to_json, :callback => params['callback']
  end

  def search
    if !params[:q].blank?
      @publishers = Publisher.search params[:q], :star => true
    end
    resp = []
    for r in @publishers
      resp << {'title' => r.title, 'id' => r.id}
    end
    render :json => resp.to_json, :callback => params['callback']
  end

  # GET /publishers
  # GET /publishers.json
  def index
    @publishers = Publisher.all
  end

  # GET /publishers/1
  # GET /publishers/1.json
  def show
  end

  # GET /publishers/new
  def new
    @publisher = Publisher.new
  end

  # GET /publishers/1/edit
  def edit
  end

  # POST /publishers
  # POST /publishers.json
  def create
    @publisher = Publisher.new(publisher_params)
    @publisher.user_id = current_user.id
    respond_to do |format|
      if @publisher.save
        format.html { redirect_to @publisher, notice: 'Publisher was successfully created.' }
        format.json { render :show, status: :created, location: @publisher }
      else
        format.html { render :new }
        format.json { render json: @publisher.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /publishers/1
  # PATCH/PUT /publishers/1.json
  def update
    respond_to do |format|
      if @publisher.update(publisher_params)
        format.html { redirect_to @publisher, notice: 'Publisher was successfully updated.' }
        format.json { render :show, status: :ok, location: @publisher }
      else
        format.html { render :edit }
        format.json { render json: @publisher.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /publishers/1
  # DELETE /publishers/1.json
  def destroy
    @publisher.destroy
    respond_to do |format|
      format.html { redirect_to publishers_url, notice: 'Publisher was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_publisher
      @publisher = Publisher.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def publisher_params
      params.require(:publisher).permit(:title, :description, :user_id, :organization_type)
    end
end
