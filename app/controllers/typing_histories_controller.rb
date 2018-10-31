class TypingHistoriesController < ApplicationController
  before_action :set_typing_history, only: [:show, :edit, :update, :destroy]

  # GET /typing_histories
  # GET /typing_histories.json
  def index
    @typing_histories = TypingHistory.all
  end

  # GET /typing_histories/1
  # GET /typing_histories/1.json
  def show
  end

  # GET /typing_histories/new
  def new
    @typing_history = TypingHistory.new
  end

  # GET /typing_histories/1/edit
  def edit
  end

  # POST /typing_histories
  # POST /typing_histories.json
  def create
    @typing_history = TypingHistory.new(typing_history_params)

    respond_to do |format|
      if @typing_history.save
        format.html { redirect_to @typing_history, notice: 'Typing history was successfully created.' }
        format.json { render :show, status: :created, location: @typing_history }
      else
        format.html { render :new }
        format.json { render json: @typing_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /typing_histories/1
  # PATCH/PUT /typing_histories/1.json
  def update
    respond_to do |format|
      if @typing_history.update(typing_history_params)
        format.html { redirect_to @typing_history, notice: 'Typing history was successfully updated.' }
        format.json { render :show, status: :ok, location: @typing_history }
      else
        format.html { render :edit }
        format.json { render json: @typing_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /typing_histories/1
  # DELETE /typing_histories/1.json
  def destroy
    @typing_history.destroy
    respond_to do |format|
      format.html { redirect_to typing_histories_url, notice: 'Typing history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_typing_history
      @typing_history = TypingHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def typing_history_params
      params.require(:typing_history).permit(:article_type_id, :article_id, :typing_id, :revision_number, :user_id, :workflow_transition_id)
    end
end
