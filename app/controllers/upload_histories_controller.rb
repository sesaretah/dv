class UploadHistoriesController < ApplicationController
  before_action :set_upload_history, only: [:show, :edit, :update, :destroy]

  # GET /upload_histories
  # GET /upload_histories.json
  def index
    @upload_histories = UploadHistory.all
  end

  # GET /upload_histories/1
  # GET /upload_histories/1.json
  def show
  end

  # GET /upload_histories/new
  def new
    @upload_history = UploadHistory.new
  end

  # GET /upload_histories/1/edit
  def edit
  end

  # POST /upload_histories
  # POST /upload_histories.json
  def create
    @upload_history = UploadHistory.new(upload_history_params)

    respond_to do |format|
      if @upload_history.save
        format.html { redirect_to @upload_history, notice: 'Upload history was successfully created.' }
        format.json { render :show, status: :created, location: @upload_history }
      else
        format.html { render :new }
        format.json { render json: @upload_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /upload_histories/1
  # PATCH/PUT /upload_histories/1.json
  def update
    respond_to do |format|
      if @upload_history.update(upload_history_params)
        format.html { redirect_to @upload_history, notice: 'Upload history was successfully updated.' }
        format.json { render :show, status: :ok, location: @upload_history }
      else
        format.html { render :edit }
        format.json { render json: @upload_history.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /upload_histories/1
  # DELETE /upload_histories/1.json
  def destroy
    @upload_history.destroy
    respond_to do |format|
      format.html { redirect_to upload_histories_url, notice: 'Upload history was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_upload_history
      @upload_history = UploadHistory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def upload_history_params
      params.require(:upload_history).permit(:uploadable_type, :uploadable_id, :token, :attachment_type, :revision_number, :user_id, :workflow_transition_id, :speaking_id)
    end
end
