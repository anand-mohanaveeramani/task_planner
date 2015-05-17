class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]

  # GET /projects
  # GET /projects.json
  def index
    @projects = focus_quarter.projects.includes(:allocations, :members).all
    @members = @projects.map(&:members).flatten.uniq
    quarter_start = Date.today.beginning_of_quarter
    @members.each { |m| m.available_date = quarter_start }
    @projects.each do |project|
      project_members = project.members
      project.start_date = project_members.map(&:available_date).sort.first
      project.pts_todo = BigDecimal(project.points)
      date = project.start_date
      until project.pts_todo <= 0 do
        project_members.each do |member|
          break if project.pts_todo <= 0
          next if member.unavailable?(date)
          project.pts_todo -= member.deliver_rate
          byebug if date.nil?
          member.available_date = member.next_available_date(date)
        end
        project.end_date = date
        date = get_next_date(date)
      end
    end
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = focus_quarter.projects.new(completion: 0)
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = focus_quarter.projects.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def prioritize
    params[:projectsidslist].each_with_index do |project_id, index|
      focus_quarter.projects.find(project_id).update_attribute(:priority, index)
    end
    render nothing: true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = focus_quarter.projects.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params.require(:project).permit(:name, :details, :quarter_id, :points, :priority, :completion)
    end

    def get_next_date(date)
      next_date = date.next
      while holiday?(next_date)
        next_date = next_date.next
      end
      next_date
    end
end
