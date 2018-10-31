class DatingHistoriesController < ApplicationController
  before_action :set_dating_history, only: [:show, :edit, :update, :destroy]

  # GET /dating_histories
  # GET /dating_histories.json
  def index
    @dating_histories = DatingHistory.all
  end

  # GET /dating_histories/1
  # GET /dating_histories/1.json
  def show
  end

  # GET /dating_histories/new
  def new
    @dating_history = DatingHistory.new
  end

  # GET /dating_histories/1/edit
  def edit
  end

  # POST /dating_histories
  # POST /dating_histories.json
  def create
    @dating_history = DatingHistory.new(dating_history_params)

    respond_to do |format|
      if @dating_history.save
        format.html { redirect_to @dating_history, notice: 'Dating history was successfully created.' }
        format.json { render :show, status: :created, location: @dating_history }
      else
        format.html { render :new }
        format.json { render json: @dating_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /dating_histories/1
  # PATCH/PUT /dating_histories/1.json
  def update
    respond_to do |format|
      if @dating_history.update(dating_history_params)
        format.html { redirect_to @dating_history, notice: 'Dating history was successfully updated.' }
        format.json { render :show, status: :ok, location: @dating_history }
      else
        format.html { render :edit }
        format.json { render json: @dating_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /dating_histories/1
  # DELETE /dating_histories/1.json
  def destroy
    @dating_history.destroy
    respond_to do |format|
      format.html { redirect_to dating_histories_url, notice: 'Dating history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dating_history
      @dating_history = DatingHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dating_history_params
      params.require(:dating_history).permit(:article_id, :article_event_id, :event_date, :revision_number, :user_id, :workflow_transition_id)
    end
end
