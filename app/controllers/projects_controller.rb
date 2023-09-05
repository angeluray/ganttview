class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]

  # GET /projects or /projects.json
  def index
    @projects = Project.all
  end

  # GET /projects/1 or /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects or /projects.json
  def create
    # @project = Project.new(project_params)

    #  # @diagram = Diagram.new(diagram_params)
     uploaded_file = params[:project][:mpp_file]

     if uploaded_file.present?
       puts "holaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
 
       # Defines a temporary file path to store the uploaded file
       temp_file_path = Rails.root.join('tmp', 'uploaded_mpp_file.mpp')
   
       # Save the uploaded file to the temporary location
       File.open(temp_file_path, 'wb') do |file|
         file.write(uploaded_file.read)
       end
       
       project = MPXJ::Reader.read(temp_file_path)
       puts "There are #{project.all_tasks.size} tasks in this project"
       puts "There are #{project.all_resources.size} resources in this project"
 
       puts "The resources are:"
       project.all_resources.each do |resource|
         puts resource.name
       end
 
       puts "The tasks are:"
       project.all_tasks.each do |task|
         puts "ID: #{task.unique_id}||||| Name: #{task.name}:  parent_project: #{task.parent_project}, parent_task: #{task.parent_task_unique_id}"
         # puts "#{task.name}: starts on #{task.start}, finishes on #{task.finish}, it's duration is #{task.duration}, parent: #{task.parent_project}, assignments: #{task.assignments}, predecessors: #{task.predecessors}, successors: #{task.successors}, childs: #{task.child_tasks}, parent_task: #{task.parent_task}"
       end

       @project = Project.new(project_name: "New project")

       project.all_tasks.each do |task|
        task_type_id = (task.unique_id == 0) ? 1 : 2

        @project.tasks.new(
          task_name: task.name,
          start_date: task.start,
          end_date: task.finish,
          duration: task.duration,
          parent_unique_id: task.parent_task_unique_id,
          unique_task_id: task.unique_id,
          task_type_id: task_type_id
        )
       end
       
      end
      
      respond_to do |format|
       if @project.save
          File.delete(temp_file_path)
          format.html { redirect_to project_url(@project), notice: "Project was successfully created." }
          format.json { render :show, status: :created, location: @project }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @project.errors, status: :unprocessable_entity }
        end
      end
      
  end

  # PATCH/PUT /projects/1 or /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to project_url(@project), notice: "Project was successfully updated." }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1 or /projects/1.json
  def destroy
    @project.destroy

    respond_to do |format|
      format.html { redirect_to projects_url, notice: "Project was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def project_params
      params.require(:project).permit(:project_name)
    end
end
