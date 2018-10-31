class FormatingHistoriesController < ApplicationController
  before_action :set_formating_history, only: [:show, :edit, :update, :destroy]

  # GET /formating_histories
  # GET /formating_histories.json
  def index
    @formating_histories = FormatingHistory.all
  end

  # GET /formating_histories/1
  # GET /formating_histories/1.json
  def show
  end

  # GET /formating_histories/new
  def new
    @formating_history = FormatingHistory.new
  end

  # GET /formating_histories/1/edit
  def edit
  end

  # POST /formating_histories
  # POST /formating_histories.json
  def create
    @formating_history = FormatingHistory.new(formating_history_params)

    respond_to do |format|
      if @formating_history.save
        format.html { redirect_to @formating_history, notice: 'Formating history was successfully created.' }
        format.json { render :show, status: :created, location: @formating_history }
      else
        format.html { render :new }
        format.json { render json: @formating_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /formating_histories/1
  # PATCH/PUT /formating_histories/1.json
  def update
    respond_to do |format|
      if @formating_history.update(formating_history_params)
        format.html { redirect_to @formating_history, notice: 'Formating history was successfully updated.' }
        format.json { render :show, status: :ok, location: @formating_history }
      else
        format.html { render :edit }
        format.json { render json: @formating_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /formating_histories/1
  # DELETE /formating_histories/1.json
  def destroy
    @formating_history.destroy
    respond_to do |format|
      format.html { redirect_to formating_histories_url, notice: 'Formating history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_formating_history
      @formating_history = FormatingHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def formating_history_params
      params.require(:formating_history).permit(:article_format_id, :article_id, :user_id, :revision_number, :workflow_state_id, :formating_id)
    end
end
