class ArticleEventsController < ApplicationController
  before_action :set_article_event, only: [:show, :edit, :update, :destroy]
  before_action :check_grant, only: [:new, :edit, :create,:update, :destroy]
  # GET /article_events
  # GET /article_events.json

  def mergerer

  end

  def merge
    @article_event_1 = ArticleEvent.find(params[:article_event_1])
    @article_event_2 = ArticleEvent.find(params[:article_event_2])
    ArticleEvent.merge_article_event(@article_event_1, @article_event_2)
    redirect_to '/article_events'
  end

  def search
    if !params[:q].blank? 
      @article_events = ArticleEvent.search params[:q], :star => true, :page =>1, :per_page => 100
    end
    resp = []
    for r in @article_events
      resp << {'title' => r.title , 'id' => r.id}
    end
    render :json => resp.to_json, :callback => params['callback']
  end

  def index
    @article_events = ArticleEvent.all.order("title asc")
  end

  # GET /article_events/1
  # GET /article_events/1.json
  def show
  end

  # GET /article_events/new
  def new
    @article_event = ArticleEvent.new
  end

  # GET /article_events/1/edit
  def edit
  end

  # POST /article_events
  # POST /article_events.json
  def create
    @article_event = ArticleEvent.new(article_event_params)
    @article_event.user_id = current_user.id
    respond_to do |format|
      if @article_event.save
        format.html { redirect_to @article_event, notice: 'Article event was successfully created.' }
        format.json { render :show, status: :created, location: @article_event }
      else
        format.html { render :new }
        format.json { render json: @article_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /article_events/1
  # PATCH/PUT /article_events/1.json
  def update
    @article_event.user_id = current_user.id
    respond_to do |format|
      if @article_event.update(article_event_params)
        format.html { redirect_to @article_event, notice: 'Article event was successfully updated.' }
        format.json { render :show, status: :ok, location: @article_event }
      else
        format.html { render :edit }
        format.json { render json: @article_event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /article_events/1
  # DELETE /article_events/1.json
  def destroy
    @article_event.destroy
    respond_to do |format|
      format.html { redirect_to article_events_url, notice: 'Article event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def check_grant
    if !grant_access("alter_article_events", current_user)
      head(403)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article_event
      @article_event = ArticleEvent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_event_params
      params.require(:article_event).permit(:title, :description)
    end
end
