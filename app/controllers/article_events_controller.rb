class ArticleEventsController < ApplicationController
  before_action :set_article_event, only: [:show, :edit, :update, :destroy]

  # GET /article_events
  # GET /article_events.json
  def index
    @article_events = ArticleEvent.all
  end

  # GET /article_events/1
  # GET /article_events/1.json
  def show
  end

  # GET /article_events/new
  def new
    if !grant_access("alter_article_events", current_user)
      head(403)
    end
    @article_event = ArticleEvent.new
  end

  # GET /article_events/1/edit
  def edit
    if !grant_access("alter_article_events", current_user)
      head(403)
    end
  end

  # POST /article_events
  # POST /article_events.json
  def create
    if !grant_access("alter_article_events", current_user)
      head(403)
    end
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
    if !grant_access("alter_article_events", current_user)
      head(403)
    end
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
    if !grant_access("alter_article_events", current_user)
      head(403)
    end
    @article_event.destroy
    respond_to do |format|
      format.html { redirect_to article_events_url, notice: 'Article event was successfully destroyed.' }
      format.json { head :no_content }
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
