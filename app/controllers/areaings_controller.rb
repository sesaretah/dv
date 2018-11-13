class AreaingsController < ApplicationController
  before_action :set_areaing, only: [:show, :edit, :update, :destroy]

  # GET /areaings
  # GET /areaings.json
  def index
    @areaings = Areaing.all
  end

  # GET /areaings/1
  # GET /areaings/1.json
  def show
  end

  # GET /areaings/new
  def new
    @areaing = Areaing.new
  end

  # GET /areaings/1/edit
  def edit
  end

  # POST /areaings
  # POST /areaings.json
  def create
    @areaing = Areaing.new(areaing_params)
    @article = @areaing.article
    respond_to do |format|
      if @areaing.save
        format.html { redirect_to @areaing, notice: 'Areaing was successfully created.' }
        format.json { render :show, status: :created, location: @areaing }
        format.js
      else
        format.html { render :new }
        format.json { render json: @areaing.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /areaings/1
  # PATCH/PUT /areaings/1.json
  def update
    respond_to do |format|
      if @areaing.update(areaing_params)
        format.html { redirect_to @areaing, notice: 'Areaing was successfully updated.' }
        format.json { render :show, status: :ok, location: @areaing }
      else
        format.html { render :edit }
        format.json { render json: @areaing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /areaings/1
  # DELETE /areaings/1.json
  def destroy
    @article = @areaing.article
    @areaing.destroy
    respond_to do |format|
      format.html { redirect_to areaings_url, notice: 'Areaing was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_areaing
      @areaing = Areaing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def areaing_params
      params.require(:areaing).permit(:article_area_id, :article_id)
    end
end
