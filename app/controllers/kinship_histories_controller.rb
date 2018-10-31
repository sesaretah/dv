class KinshipHistoriesController < ApplicationController
  before_action :set_kinship_history, only: [:show, :edit, :update, :destroy]

  # GET /kinship_histories
  # GET /kinship_histories.json
  def index
    @kinship_histories = KinshipHistory.all
  end

  # GET /kinship_histories/1
  # GET /kinship_histories/1.json
  def show
  end

  # GET /kinship_histories/new
  def new
    @kinship_history = KinshipHistory.new
  end

  # GET /kinship_histories/1/edit
  def edit
  end

  # POST /kinship_histories
  # POST /kinship_histories.json
  def create
    @kinship_history = KinshipHistory.new(kinship_history_params)

    respond_to do |format|
      if @kinship_history.save
        format.html { redirect_to @kinship_history, notice: 'Kinship history was successfully created.' }
        format.json { render :show, status: :created, location: @kinship_history }
      else
        format.html { render :new }
        format.json { render json: @kinship_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /kinship_histories/1
  # PATCH/PUT /kinship_histories/1.json
  def update
    respond_to do |format|
      if @kinship_history.update(kinship_history_params)
        format.html { redirect_to @kinship_history, notice: 'Kinship history was successfully updated.' }
        format.json { render :show, status: :ok, location: @kinship_history }
      else
        format.html { render :edit }
        format.json { render json: @kinship_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /kinship_histories/1
  # DELETE /kinship_histories/1.json
  def destroy
    @kinship_history.destroy
    respond_to do |format|
      format.html { redirect_to kinship_histories_url, notice: 'Kinship history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kinship_history
      @kinship_history = KinshipHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kinship_history_params
      params.require(:kinship_history).permit(:user_id, :kin_id, :article_id, :article_relation_type_id, :revision_number, :user_id, :workflow_transition_id)
    end
end
