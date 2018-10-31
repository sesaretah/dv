class TaggingHistoriesController < ApplicationController
  before_action :set_tagging_history, only: [:show, :edit, :update, :destroy]

  # GET /tagging_histories
  # GET /tagging_histories.json
  def index
    @tagging_histories = TaggingHistory.all
  end

  # GET /tagging_histories/1
  # GET /tagging_histories/1.json
  def show
  end

  # GET /tagging_histories/new
  def new
    @tagging_history = TaggingHistory.new
  end

  # GET /tagging_histories/1/edit
  def edit
  end

  # POST /tagging_histories
  # POST /tagging_histories.json
  def create
    @tagging_history = TaggingHistory.new(tagging_history_params)

    respond_to do |format|
      if @tagging_history.save
        format.html { redirect_to @tagging_history, notice: 'Tagging history was successfully created.' }
        format.json { render :show, status: :created, location: @tagging_history }
      else
        format.html { render :new }
        format.json { render json: @tagging_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tagging_histories/1
  # PATCH/PUT /tagging_histories/1.json
  def update
    respond_to do |format|
      if @tagging_history.update(tagging_history_params)
        format.html { redirect_to @tagging_history, notice: 'Tagging history was successfully updated.' }
        format.json { render :show, status: :ok, location: @tagging_history }
      else
        format.html { render :edit }
        format.json { render json: @tagging_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tagging_histories/1
  # DELETE /tagging_histories/1.json
  def destroy
    @tagging_history.destroy
    respond_to do |format|
      format.html { redirect_to tagging_histories_url, notice: 'Tagging history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tagging_history
      @tagging_history = TaggingHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tagging_history_params
      params.require(:tagging_history).permit(:taggable_id, :taggable_type, :target_id, :target_type, :user_id, :revision_number, :article_id, :workflow_transition_id)
    end
end
