class KinshipsController < ApplicationController
  before_action :set_kinship, only: [:show, :edit, :update, :destroy, :change_rank]

  def change_rank
    @article = @kinship.article
    if params[:to] == 'up'
      @kinship.rank = @kinship.rank.to_i + 1
    else
      @kinship.rank = @kinship.rank.to_i - 1
    end
    @kinship.save
  end
  # GET /kinships
  # GET /kinships.json
  def index
    @kinships = Kinship.all
  end

  # GET /kinships/1
  # GET /kinships/1.json
  def show
  end

  # GET /kinships/new
  def new
    @kinship = Kinship.new
  end

  # GET /kinships/1/edit
  def edit
  end

  # POST /kinships
  # POST /kinships.json
  def create
    @kinship = Kinship.new(kinship_params)
    @article = @kinship.article
    respond_to do |format|
      if @kinship.save
        format.html { redirect_to @kinship, notice: 'Kinship was successfully created.' }
        format.json { render :show, status: :created, location: @kinship }
        format.js
      else
        format.html { render :new }
        format.json { render json: @kinship.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # PATCH/PUT /kinships/1
  # PATCH/PUT /kinships/1.json
  def update
    respond_to do |format|
      if @kinship.update(kinship_params)
        format.html { redirect_to @kinship, notice: 'Kinship was successfully updated.' }
        format.json { render :show, status: :ok, location: @kinship }
      else
        format.html { render :edit }
        format.json { render json: @kinship.errors, status: :unprocessable_entity }
        format.js
      end
    end
  end

  # DELETE /kinships/1
  # DELETE /kinships/1.json
  def destroy
    @article = @kinship.article
    @kinship.destroy
    respond_to do |format|
      format.html { redirect_to kinships_url, notice: 'Kinship was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_kinship
      @kinship = Kinship.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def kinship_params
      params.require(:kinship).permit(:user_id, :kin_id, :article_relation_type_id, :article_id)
    end
end
