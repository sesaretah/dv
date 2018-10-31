class ContributionHistoriesController < ApplicationController
  before_action :set_contribution_history, only: [:show, :edit, :update, :destroy]

  # GET /contribution_histories
  # GET /contribution_histories.json
  def index
    @contribution_histories = ContributionHistory.all
  end

  # GET /contribution_histories/1
  # GET /contribution_histories/1.json
  def show
  end

  # GET /contribution_histories/new
  def new
    @contribution_history = ContributionHistory.new
  end

  # GET /contribution_histories/1/edit
  def edit
  end

  # POST /contribution_histories
  # POST /contribution_histories.json
  def create
    @contribution_history = ContributionHistory.new(contribution_history_params)

    respond_to do |format|
      if @contribution_history.save
        format.html { redirect_to @contribution_history, notice: 'Contribution history was successfully created.' }
        format.json { render :show, status: :created, location: @contribution_history }
      else
        format.html { render :new }
        format.json { render json: @contribution_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /contribution_histories/1
  # PATCH/PUT /contribution_histories/1.json
  def update
    respond_to do |format|
      if @contribution_history.update(contribution_history_params)
        format.html { redirect_to @contribution_history, notice: 'Contribution history was successfully updated.' }
        format.json { render :show, status: :ok, location: @contribution_history }
      else
        format.html { render :edit }
        format.json { render json: @contribution_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /contribution_histories/1
  # DELETE /contribution_histories/1.json
  def destroy
    @contribution_history.destroy
    respond_to do |format|
      format.html { redirect_to contribution_histories_url, notice: 'Contribution history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contribution_history
      @contribution_history = ContributionHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def contribution_history_params
      params.require(:contribution_history).permit(:article_id, :role_id, :duty_id, :profile_id, :revision_number, :user_id, :workflow_transition_id, :contribution_id)
    end
end
