class AssignmentsController < ApplicationController
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]

  # GET /assignments
  # GET /assignments.json
  def index
    @assignments = Assignment.all
  end

  # GET /assignments/1
  # GET /assignments/1.json
  def show
  end

  # GET /assignments/new
  def new
    if !grant_access("edit_assignments", current_user)
      head(403)
    end
    @assignment = Assignment.new
  end

  # GET /assignments/1/edit
  def edit
  end

  # POST /assignments
  # POST /assignments.json
  def create
    if !grant_access("edit_assignments", current_user)
      head(403)
    end
    @assignment = Assignment.new(assignment_params)
    @assignment.assigner_id = current_user.id
    respond_to do |format|
      if @assignment.save
        MailerWorker.perform_async(@assignment.user_id, 'role_assignment', @assignment.user.profile.fullname, ' ', ' ', " ")
        format.html { redirect_to '/assignments', notice: 'Assignment was successfully created.' }
        format.json { render :show, status: :created, location: @assignment }
      else
        format.html { render :new }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignments/1
  # PATCH/PUT /assignments/1.json
  def update
    if !grant_access("alter_assignments", current_user)
      head(403)
    end
    respond_to do |format|
      if @assignment.update(assignment_params)
        format.html { redirect_to @assignment, notice: 'Assignment was successfully updated.' }
        format.json { render :show, status: :ok, location: @assignment }
      else
        format.html { render :edit }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1
  # DELETE /assignments/1.json
  def destroy
    if grant_access("alter_assignments", current_user) || @assignment.assigner_id == current_user.id
      send_mail user_id: @assignment.user_id, role_title: @assignment.role.title, mail_type: 'role_unassignment'
      @assignment.destroy
      respond_to do |format|
        format.html { redirect_to assignments_url, notice: 'Assignment was successfully destroyed.' }
        format.json { head :no_content }
      end
    else 
      head(403)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_assignment
      @assignment = Assignment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def assignment_params
      params.require(:assignment).permit(:user_id, :role_id, :assigner_id)
    end
end
