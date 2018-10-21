class DatingsController < ApplicationController
  before_action :set_dating, only: [:show, :edit, :update, :destroy]

  # GET /datings
  # GET /datings.json
  def index
    @datings = Dating.all
  end

  # GET /datings/1
  # GET /datings/1.json
  def show
  end

  # GET /datings/new
  def new
    @dating = Dating.new
  end

  # GET /datings/1/edit
  def edit
    @dating = Dating.find(params[:id])
    @article = @dating.article
  end

  # POST /datings
  # POST /datings.json
  def create
    @dating = Dating.new(dating_params)
    @dating.event_date = JalaliDate.to_gregorian(params[:event_date_yyyy],params[:event_date_mm],params[:event_date_dd])
    @article = @dating.article
    respond_to do |format|
      if @dating.save
        format.html { redirect_to @dating, notice: 'Dating was successfully created.' }
        format.json { render :show, status: :created, location: @dating }
        format.js
      else
        format.html { render :new }
        format.json { render json: @dating.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /datings/1
  # PATCH/PUT /datings/1.json
  def update
    @dating.event_date = JalaliDate.to_gregorian(params[:event_date_yyyy],params[:event_date_mm],params[:event_date_dd])
    @article = @dating.article
    respond_to do |format|
      if @dating.update(dating_params)
        format.html { redirect_to @dating, notice: 'Dating was successfully updated.' }
        format.json { render :show, status: :ok, location: @dating }
        format.js
      else
        format.html { render :edit }
        format.json { render json: @dating.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /datings/1
  # DELETE /datings/1.json
  def destroy
    @article = @dating.article
    @dating.destroy
    respond_to do |format|
      format.html { redirect_to datings_url, notice: 'Dating was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dating
      @dating = Dating.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dating_params
      params.require(:dating).permit(:article_event_id, :article_id, :event_date)
    end
end
