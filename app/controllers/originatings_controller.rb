class OriginatingsController < ApplicationController
  before_action :set_originating, only: [:show, :edit, :update, :destroy]

  # GET /originatings
  # GET /originatings.json
  def index
    @originatings = Originating.all
  end

  # GET /originatings/1
  # GET /originatings/1.json
  def show
  end

  # GET /originatings/new
  def new
    @originating = Originating.new
  end

  # GET /originatings/1/edit
  def edit
  end

  # POST /originatings
  # POST /originatings.json
  def create
    @originating = Originating.new(originating_params)
    @article = @originating.article
    respond_to do |format|
      if @originating.save
        format.html { redirect_to @originating, notice: 'Originating was successfully created.' }
        format.json { render :show, status: :created, location: @originating }
        format.js
      else
        format.html { render :new }
        format.json { render json: @originating.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /originatings/1
  # PATCH/PUT /originatings/1.json
  def update
    respond_to do |format|
      if @originating.update(originating_params)
        format.html { redirect_to @originating, notice: 'Originating was successfully updated.' }
        format.json { render :show, status: :ok, location: @originating }
      else
        format.html { render :edit }
        format.json { render json: @originating.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /originatings/1
  # DELETE /originatings/1.json
  def destroy
    @article = @originating.article
    @originating.destroy
    respond_to do |format|
      format.html { redirect_to originatings_url, notice: 'Originating was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_originating
      @originating = Originating.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def originating_params
      params.require(:originating).permit(:article_id, :article_source_id)
    end
end
