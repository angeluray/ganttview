class DiagramsController < ApplicationController
  before_action :set_diagram, only: %i[ show edit update destroy ]

  # GET /diagrams or /diagrams.json
  def index
    @diagrams = Diagram.all
  end

  # GET /diagrams/1 or /diagrams/1.json
  def show
  end

  # GET /diagrams/new
  def new
    @diagram = Diagram.new
  end

  # GET /diagrams/1/edit
  def edit
  end

  # POST /diagrams or /diagrams.json
  def create
    # @diagram = Diagram.new(diagram_params)
    uploaded_file = params[:diagram][:mpp_file]

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
      
      File.delete(temp_file_path)
    end

    respond_to do |format|
      if @diagram.save
        format.html { redirect_to diagram_url(@diagram), notice: "Diagram was successfully created." }
        format.json { render :show, status: :created, location: @diagram }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @diagram.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /diagrams/1 or /diagrams/1.json
  def update
    respond_to do |format|
      if @diagram.update(diagram_params)
        format.html { redirect_to diagram_url(@diagram), notice: "Diagram was successfully updated." }
        format.json { render :show, status: :ok, location: @diagram }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @diagram.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diagrams/1 or /diagrams/1.json
  def destroy
    @diagram.destroy

    respond_to do |format|
      format.html { redirect_to diagrams_url, notice: "Diagram was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diagram
      @diagram = Diagram.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def diagram_params
      params.require(:diagram).permit(:file, :task_name, :description, :start_date, :end_date, :progress, :duration, :priority, :parent)
    end
end
