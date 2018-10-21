class TitlingsController < ApplicationController
  before_action :set_titling, only: [:show, :edit, :update, :destroy]

  def add_item

  end
  # GET /titlings
  # GET /titlings.json
  def index
    @titlings = Titling.all
  end

  # GET /titlings/1
  # GET /titlings/1.json
  def show
  end

  # GET /titlings/new
  def new
    @titling = Titling.new
  end

  # GET /titlings/1/edit
  def edit
  end

  # POST /titlings
  # POST /titlings.json
  def create
    @titling = Titling.new(titling_params)

    respond_to do |format|
      if @titling.save
        format.html { redirect_to @titling, notice: 'Titling was successfully created.' }
        format.json { render :show, status: :created, location: @titling }
      else
        format.html { render :new }
        format.json { render json: @titling.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /titlings/1
  # PATCH/PUT /titlings/1.json
  def update
    respond_to do |format|
      if @titling.update(titling_params)
        format.html { redirect_to @titling, notice: 'Titling was successfully updated.' }
        format.json { render :show, status: :ok, location: @titling }
      else
        format.html { render :edit }
        format.json { render json: @titling.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /titlings/1
  # DELETE /titlings/1.json
  def destroy
    @titling.destroy
    respond_to do |format|
      format.html { redirect_to titlings_url, notice: 'Titling was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_titling
      @titling = Titling.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def titling_params
      params.require(:titling).permit(:title_type_id, :article_id, :status, :content)
    end
end
