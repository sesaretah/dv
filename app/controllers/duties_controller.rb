class DutiesController < ApplicationController
  before_action :set_duty, only: [:show, :edit, :update, :destroy]


  def mergerer

  end

  def merge
    @duty_1 = Duty.find(params[:duty_1])
    @duty_2 = Duty.find(params[:duty_2])
    Duty.merge_duty(@duty_1, @duty_2)
    redirect_to '/duties'
  end

  def search
    if !params[:q].blank?
      @duties = Duty.search params[:q], :star => true
    end
    resp = []
    for r in @duties
      resp << {'title' => r.title , 'id' => r.id}
    end
    render :json => resp.to_json, :callback => params['callback']
  end
  # GET /duties
  # GET /duties.json
  def index
    @duties = Duty.all.order("title asc")
  end

  # GET /duties/1
  # GET /duties/1.json
  def show
  end

  # GET /duties/new
  def new
    if !grant_access("alter_duties", current_user)
      head(403)
    end
    @duty = Duty.new
  end

  # GET /duties/1/edit
  def edit
    if !grant_access("alter_duties", current_user)
      head(403)
    end
  end

  # POST /duties
  # POST /duties.json
  def create
    if !grant_access("alter_duties", current_user)
      head(403)
    end
    @duty = Duty.new(duty_params)
    @duty.user_id = current_user.id
    respond_to do |format|
      if @duty.save
        format.html { redirect_to @duty, notice: 'Duty was successfully created.' }
        format.json { render :show, status: :created, location: @duty }
      else
        format.html { render :new }
        format.json { render json: @duty.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /duties/1
  # PATCH/PUT /duties/1.json
  def update
    if !grant_access("alter_duties", current_user)
      head(403)
    end
    @duty.user_id = current_user.id
    respond_to do |format|
      if @duty.update(duty_params)
        format.html { redirect_to @duty, notice: 'Duty was successfully updated.' }
        format.json { render :show, status: :ok, location: @duty }
      else
        format.html { render :edit }
        format.json { render json: @duty.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /duties/1
  # DELETE /duties/1.json
  def destroy
    if !grant_access("alter_duties", current_user)
      head(403)
    end
    @duty.destroy
    respond_to do |format|
      format.html { redirect_to duties_url, notice: 'Duty was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_duty
    @duty = Duty.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def duty_params
    params.require(:duty).permit(:title, :description)
  end
end
