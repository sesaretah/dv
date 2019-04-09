class SectionItemsController < ApplicationController
  before_action :set_section_item, only: [:show, :edit, :update, :destroy]
  before_action :check_grant, only: [:new, :edit, :create,:update, :destroy]
  def search
    if !params[:q].blank?
      @section_items = SectionItem.search params[:q], :star => true
    end
    resp = []
    for r in @section_items
      resp << {'title' => r.title , 'id' => r.id}
    end
    render :json => resp.to_json, :callback => params['callback']
  end
  # GET /section_items
  # GET /section_items.json
  def index
    @section_items = SectionItem.all.order("title asc")
  end

  # GET /section_items/1
  # GET /section_items/1.json
  def show
  end

  # GET /section_items/new
  def new
    @section_item = SectionItem.new
  end

  # GET /section_items/1/edit
  def edit
  end

  # POST /section_items
  # POST /section_items.json
  def create
    @section_item = SectionItem.new(section_item_params)
    @section_item.user_id = current_user.id
    respond_to do |format|
      if @section_item.save
        format.html { redirect_to @section_item, notice: 'Section item was successfully created.' }
        format.json { render :show, status: :created, location: @section_item }
      else
        format.html { render :new }
        format.json { render json: @section_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /section_items/1
  # PATCH/PUT /section_items/1.json
  def update
    @section_item.user_id = current_user.id
    respond_to do |format|
      if @section_item.update(section_item_params)
        format.html { redirect_to @section_item, notice: 'Section item was successfully updated.' }
        format.json { render :show, status: :ok, location: @section_item }
      else
        format.html { render :edit }
        format.json { render json: @section_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /section_items/1
  # DELETE /section_items/1.json
  def destroy
    @section_item.destroy
    respond_to do |format|
      format.html { redirect_to section_items_url, notice: 'Section item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def check_grant
    if !grant_access("alter_section_items", current_user)
      head(403)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section_item
      @section_item = SectionItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def section_item_params
      params.require(:section_item).permit(:title, :description,:klass_name)
    end
end
