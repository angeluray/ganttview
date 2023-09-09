class ProjectsController < ApplicationController
  before_action :set_project, only: %i[ show edit update destroy ]

  def index
    @project = Project.new
    @projects = Project.all
  end

  def show
    # Creates object of hashes to be consumed by the stimulus controller "gantt.controller.js"
    @project_tasks_data = { 
      "data" =>
      @project.tasks.map do |task|
        {
            id: task.unique_task_id == 0 ? 999 : task.unique_task_id,
            text: task.task_name,
            start_date: task.start_date.strftime('%d-%m-%Y'), # Extracts the date
            duration: task.duration,
            type: task.parent_unique_id == 0 ? "project" : nil,
            open: task.parent_unique_id == 0 ? true : nil,
            parent: task.task_type_id == 2 ? task.parent_unique_id : 0
          }.compact
        end,
        "links" =>
        @project.tasks.where("task_type_id = 2 OR relation IS NOT NULL").pluck(:unique_task_id, :relation).map do |unique_task_id, relation|
          {
            id: unique_task_id,
            source: relation,
            target: unique_task_id,
            type: 0
          }
        end
      }
      # This object is used by gantt.parse to be able to display the project tasks.

      respond_to do |format|
        format.html # Render the show view
        format.json { render json: @project_tasks_data } # Render @project_tasks_data as JSON whenever stimulus send the GET request
      end
  end

  def new
    @project = Project.new
  end

  def create
     uploaded_file = params[:project][:mpp_file]

    if uploaded_file.present?
 
       # Defines a temporary file path to store the uploaded file
       temp_file_path = Rails.root.join('tmp', 'uploaded_mpp_file.mpp')
   
       # Save the uploaded file to the temporary location
       File.open(temp_file_path, 'wb') do |file|
         file.write(uploaded_file.read)
       end
       
      # Use MPXJ gem to get the values from the .mpp file
       project = MPXJ::Reader.read(temp_file_path)

      # The comments below were left on purpose for future development enhancements
      # puts "#{project.all_tasks.size} tasks are present this project"
 
      #  puts "The project's tasks are:"
      #  project.all_tasks.each do |task|
      #  puts "ID: #{task.unique_id}||||| Name: #{task.name}:  parent_project: #{task.parent_project}, parent_task: #{task.parent_task_unique_id}, start: #{task.start.to_date}, end: #{task.finish.to_date}, actual: #{task.actual_start.to_date}, early: #{task.early_start.to_date}, late: #{task.late_start.to_date}, late-f: #{task.late_finish.to_date}, early-f: #{task.early_finish.to_date}"
         
      # puts "this is #{task.predecessors}"
      # if task.predecessors.present?
      # task.predecessors.each do |relation|
      #     puts relation.methods
      # puts "it's related to #{relation.task_unique_id}}"
      #  predecessor_id = predecessor.unique_id  # Adjust the key if necessary
      #  puts "Has >>>#{predecessor.name}<<< as its Predecessor with an ID: #{predecessor.unique_id}"
      # end
      #  end
      #  puts "#{task.name}: starts on #{task.start}, finishes on #{task.finish}, it's duration is #{task.duration}, parent: #{task.parent_project}, assignments: #{task.assignments}, predecessors: #{task.predecessors}, successors: #{task.successors}, childs: #{task.child_tasks}, parent_task: #{task.parent_task}"
      #  puts "-----------------END OF TASK INFORMATION-----------------"
      #  end

      # Assigns a defaults project name
      @project = Project.new(project_name: "New project")

      project.all_tasks.each do |task|

        # Task with parent_task_unique_id equal to zero are "projects" otherwise are normal tasks.
        task_type_id = (task.parent_task_unique_id == 0) ? 1 : 2

        # Increase the end-date 1 day to match visually the exact date of project ending.
        project_end_date = task.finish + 1.day

        duration = (project_end_date.to_date - task.start.to_date).to_i

        # Creates variable to store ids of relations by hierarchy
        predecessor_task_id = nil

        # Organize the relations within the hierarchy
        if task.predecessors.present?
          task.predecessors.each do |relation|
            predecessor_task_id = relation.task_unique_id
          end
        end

        @project.tasks.new(
          task_name: task.name,
          start_date: task.start,
          end_date: project_end_date,
          duration: duration,
          parent_unique_id: task.parent_task_unique_id,
          unique_task_id: task.unique_id,
          task_type_id: task_type_id,
          relation: predecessor_task_id
        )

        # Reset the value to bring space for the new one
        predecessor_task_id = nil
      end
    end 
      
    respond_to do |format|
      if @project.save
        File.delete(temp_file_path) # Delete temporal file to avoid memory consuming 
        format.html { redirect_to project_url(@project), notice: "Project was successfully created." }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    if project_params.present?
      update_project
    else
      update_task
    end
  end

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

    # Encapsulates project's name update logic.
    def update_project
      respond_to do |format|
        if @project.update(project_params)
          format.html { redirect_to project_url(@project), notice: "Project's name successfully changed." }
          format.json { render :show, status: :ok, location: @project }
        else
          format.html { render :edit, status: :unprocessable_entity }
          format.json { render json: @project.errors, status: :unprocessable_entity }
        end
      end
    end

    # Encapsulates Task's fields updates logic.
    def update_task
      # Parse the JSON data from the request body
      task_data = JSON.parse(request.body.read)

      # Parse dates from strf format to ISO Standard
      # to match the start/end columns data types within the database
      parsed_start_date = DateTime.parse(task_data['start_date'])
      parsed_end_date = DateTime.parse(task_data['end_date'])

      # unique_task_id contains the id assigned to the task from the .mpp file
      # and it's use as the main reference.
      @task = @project.tasks.find_by(unique_task_id: task_data['id']) 
      
      if @task # Checks wether the task exists or not

        if @task.task_name != task_data['text']
          @task.task_name = task_data['text']
        end
      
        if @task.start_date != parsed_start_date
          @task.start_date = parsed_start_date
        end
      
        if @task.end_date != parsed_end_date
          @task.end_date = parsed_end_date
        end
      
        if @task.duration != task_data['duration']
          @task.duration = task_data['duration']
        end

        if @task.save
          # Returns a updated task into JSON format as a response
          render json: @task, status: :ok
        else
          render json: { errors: @task.errors }, status: :unprocessable_entity
        end
      else
        render json: { error: 'Task not found' }, status: :not_found
      end
    end

    def project_params
      params.require(:project).permit(:project_name)
    end
end
