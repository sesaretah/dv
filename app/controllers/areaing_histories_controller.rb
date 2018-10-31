class AreaingHistoriesController < ApplicationController
  before_action :set_areaing_history, only: [:show, :edit, :update, :destroy]

  # GET /areaing_histories
  # GET /areaing_histories.json
  def index
    @areaing_histories = AreaingHistory.all
  end

  # GET /areaing_histories/1
  # GET /areaing_histories/1.json
  def show
  end

  # GET /areaing_histories/new
  def new
    @areaing_history = AreaingHistory.new
  end

  # GET /areaing_histories/1/edit
  def edit
  end

  # POST /areaing_histories
  # POST /areaing_histories.json
  def create
    @areaing_history = AreaingHistory.new(areaing_history_params)

    respond_to do |format|
      if @areaing_history.save
        format.html { redirect_to @areaing_history, notice: 'Areaing history was successfully created.' }
        format.json { render :show, status: :created, location: @areaing_history }
      else
        format.html { render :new }
        format.json { render json: @areaing_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /areaing_histories/1
  # PATCH/PUT /areaing_histories/1.json
  def update
    respond_to do |format|
      if @areaing_history.update(areaing_history_params)
        format.html { redirect_to @areaing_history, notice: 'Areaing history was successfully updated.' }
        format.json { render :show, status: :ok, location: @areaing_history }
      else
        format.html { render :edit }
        format.json { render json: @areaing_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /areaing_histories/1
  # DELETE /areaing_histories/1.json
  def destroy
    @areaing_history.destroy
    respond_to do |format|
      format.html { redirect_to areaing_histories_url, notice: 'Areaing history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_areaing_history
      @areaing_history = AreaingHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def areaing_history_params
      params.require(:areaing_history).permit(:article_id, :article_area_id, :revision_number, :user_id, :workflow_transition_id, :areaing_id)
    end
end
