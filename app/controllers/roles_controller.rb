class RolesController < ApplicationController
  before_action :set_role, only: [:show, :edit, :update, :destroy]


  def mergerer

  end

  def merge
    @role_1 = Role.find(params[:role_1])
    @role_2 = Role.find(params[:role_2])
    Role.merge_role(@role_1, @role_2)
    redirect_to '/roles'
  end

  def search
    if !params[:q].blank?
      @roles = Role.search params[:q], :star => true
    end
    resp = []
    for r in @roles
      resp << {'title' => r.title , 'id' => r.id}
    end
    render :json => resp.to_json, :callback => params['callback']
  end
  # GET /roles
  # GET /roles.json
  def index
    @roles = Role.all.order("title asc")
  end

  # GET /roles/1
  # GET /roles/1.json
  def show
  end

  # GET /roles/new
  def new
    if !grant_access("edit_roles", current_user)
      head(403)
    end
    @role = Role.new
  end

  # GET /roles/1/edit
  def edit
    if !grant_access("alter_roles", current_user)
      head(403)
    end
  end

  # POST /roles
  # POST /roles.json
  def create
    if !grant_access("edit_roles", current_user)
      head(403)
    end
    @role = Role.new(role_params)
    @role.user_id = current_user.id
    respond_to do |format|
      if @role.save
        format.html { redirect_to @role, notice: 'Role was successfully created.' }
        format.json { render :show, status: :created, location: @role }
      else
        format.html { render :new }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /roles/1
  # PATCH/PUT /roles/1.json
  def update
    if !grant_access("alter_roles", current_user)
      head(403)
    end
    @role.user_id = current_user.id
    @role.start_point = false if !params[:role][:start_point]
    respond_to do |format|
      if @role.update(role_params)
        format.html { redirect_to @role, notice: 'Role was successfully updated.' }
        format.json { render :show, status: :ok, location: @role }
      else
        format.html { render :edit }
        format.json { render json: @role.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /roles/1
  # DELETE /roles/1.json
  def destroy
    if !grant_access("alter_roles", current_user)
      head(403)
    end
    @role.destroy
    respond_to do |format|
      format.html { redirect_to roles_url, notice: 'Role was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def role_params
      params.require(:role).permit(:title, :description, :abr, :start_point)
    end
end
