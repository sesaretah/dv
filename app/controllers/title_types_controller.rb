class TitleTypesController < ApplicationController
  before_action :set_title_type, only: [:show, :edit, :update, :destroy]

  # GET /title_types
  # GET /title_types.json
  def index
    @title_types = TitleType.all.order("title asc")
  end

  # GET /title_types/1
  # GET /title_types/1.json
  def show
  end

  # GET /title_types/new
  def new
    if !grant_access("alter_title_types", current_user)
      head(403)
    end
    @title_type = TitleType.new
  end

  # GET /title_types/1/edit
  def edit
    if !grant_access("alter_title_types", current_user)
      head(403)
    end
  end

  # POST /title_types
  # POST /title_types.json
  def create
    if !grant_access("alter_title_types", current_user)
      head(403)
    end
    @title_type = TitleType.new(title_type_params)
    @title_type.user_id = current_user.id
    respond_to do |format|
      if @title_type.save
        format.html { redirect_to @title_type, notice: 'Title type was successfully created.' }
        format.json { render :show, status: :created, location: @title_type }
      else
        format.html { render :new }
        format.json { render json: @title_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /title_types/1
  # PATCH/PUT /title_types/1.json
  def update
    if !grant_access("alter_title_types", current_user)
      head(403)
    end
    @title_type.user_id = current_user.id
    respond_to do |format|
      if @title_type.update(title_type_params)
        format.html { redirect_to @title_type, notice: 'Title type was successfully updated.' }
        format.json { render :show, status: :ok, location: @title_type }
      else
        format.html { render :edit }
        format.json { render json: @title_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /title_types/1
  # DELETE /title_types/1.json
  def destroy
    if !grant_access("alter_title_types", current_user)
      head(403)
    end
    @title_type.destroy
    respond_to do |format|
      format.html { redirect_to title_types_url, notice: 'Title type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_title_type
      @title_type = TitleType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def title_type_params
      params.require(:title_type).permit(:title, :description)
    end
end
