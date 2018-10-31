class OriginatingHistoriesController < ApplicationController
  before_action :set_originating_history, only: [:show, :edit, :update, :destroy]

  # GET /originating_histories
  # GET /originating_histories.json
  def index
    @originating_histories = OriginatingHistory.all
  end

  # GET /originating_histories/1
  # GET /originating_histories/1.json
  def show
  end

  # GET /originating_histories/new
  def new
    @originating_history = OriginatingHistory.new
  end

  # GET /originating_histories/1/edit
  def edit
  end

  # POST /originating_histories
  # POST /originating_histories.json
  def create
    @originating_history = OriginatingHistory.new(originating_history_params)

    respond_to do |format|
      if @originating_history.save
        format.html { redirect_to @originating_history, notice: 'Originating history was successfully created.' }
        format.json { render :show, status: :created, location: @originating_history }
      else
        format.html { render :new }
        format.json { render json: @originating_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /originating_histories/1
  # PATCH/PUT /originating_histories/1.json
  def update
    respond_to do |format|
      if @originating_history.update(originating_history_params)
        format.html { redirect_to @originating_history, notice: 'Originating history was successfully updated.' }
        format.json { render :show, status: :ok, location: @originating_history }
      else
        format.html { render :edit }
        format.json { render json: @originating_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /originating_histories/1
  # DELETE /originating_histories/1.json
  def destroy
    @originating_history.destroy
    respond_to do |format|
      format.html { redirect_to originating_histories_url, notice: 'Originating history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_originating_history
      @originating_history = OriginatingHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def originating_history_params
      params.require(:originating_history).permit(:article_id, :article_source_id, :originating_id, :revision_number, :user_id, :workflow_transition_id)
    end
end
