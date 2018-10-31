class SpeakingHistoriesController < ApplicationController
  before_action :set_speaking_history, only: [:show, :edit, :update, :destroy]

  # GET /speaking_histories
  # GET /speaking_histories.json
  def index
    @speaking_histories = SpeakingHistory.all
  end

  # GET /speaking_histories/1
  # GET /speaking_histories/1.json
  def show
  end

  # GET /speaking_histories/new
  def new
    @speaking_history = SpeakingHistory.new
  end

  # GET /speaking_histories/1/edit
  def edit
  end

  # POST /speaking_histories
  # POST /speaking_histories.json
  def create
    @speaking_history = SpeakingHistory.new(speaking_history_params)

    respond_to do |format|
      if @speaking_history.save
        format.html { redirect_to @speaking_history, notice: 'Speaking history was successfully created.' }
        format.json { render :show, status: :created, location: @speaking_history }
      else
        format.html { render :new }
        format.json { render json: @speaking_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /speaking_histories/1
  # PATCH/PUT /speaking_histories/1.json
  def update
    respond_to do |format|
      if @speaking_history.update(speaking_history_params)
        format.html { redirect_to @speaking_history, notice: 'Speaking history was successfully updated.' }
        format.json { render :show, status: :ok, location: @speaking_history }
      else
        format.html { render :edit }
        format.json { render json: @speaking_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /speaking_histories/1
  # DELETE /speaking_histories/1.json
  def destroy
    @speaking_history.destroy
    respond_to do |format|
      format.html { redirect_to speaking_histories_url, notice: 'Speaking history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_speaking_history
      @speaking_history = SpeakingHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def speaking_history_params
      params.require(:speaking_history).permit(:article_id, :language_id, :revision_number, :user_id, :workflow_transition_id, :speaking_id)
    end
end
