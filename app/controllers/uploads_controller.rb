class UploadsController < ApplicationController
  before_action :set_upload, only: [:show, :edit, :update, :destroy]
  before_action :check_grant, only: [:new, :edit, :create,:update, :destroy]
  skip_before_action :verify_authenticity_token, only: [:create]
  def remoted
    @upload = Upload.find(params[:id])
    if @upload.uploadable_type == 'Article'
      @article = Article.find_by_id( @upload.uploadable_id)
    end
    @upload.destroy
    respond_to do |format|
      format.json { head :no_content }
      format.js
      format.html { redirect_to @article}
    end
  end
  # GET /uploads
  # GET /uploads.json
  def index
    @uploads = Upload.all
  end

  # GET /uploads/1
  # GET /uploads/1.json
  def show
    if @upload.uploadable_type == 'Article'
      @article = Article.find_by_id( @upload.uploadable_id)
    end
  end


  # GET /uploads/new
  def new
    @upload = Upload.new
  end

  # GET /uploads/1/edit
  def edit
  end

  # POST /uploads
  # POST /uploads.json
  def create
    @upload = Upload.new(upload_params)
        @upload.attachment = params[:file]
        @upload.user_id = current_user.id
        if @upload.uploadable_type == 'Article'
          @article = Article.find_by_id( @upload.uploadable_id)
        end
    respond_to do |format|
      if @upload.save
        format.html { redirect_to @upload, notice: 'Upload was successfully created.' }
        format.json { render :show, status: :created, location: @upload }
        format.js
      else
        format.html { render :new }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /uploads/1
  # PATCH/PUT /uploads/1.json
  def update
    respond_to do |format|
      if @upload.update(upload_params)
        format.html { redirect_to @upload, notice: 'Upload was successfully updated.' }
        format.json { render :show, status: :ok, location: @upload }
      else
        format.html { render :edit }
        format.json { render json: @upload.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /uploads/1
  # DELETE /uploads/1.json
  def destroy
    @upload.destroy
    respond_to do |format|
      format.html { redirect_to uploads_url, notice: 'Upload was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def check_grant
    if !grant_access("alter_keywords", current_user)
     # head(403)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_upload
      @upload = Upload.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def upload_params
      params.require(:upload).permit(:uploadable_type, :uploadable_id, :token, :attachment, :attachment_type, :title, :detail)
    end
end
