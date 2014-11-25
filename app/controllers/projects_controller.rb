class ProjectsController < ApplicationController
  
  
  def index
     @projects = current_user.employee.projects
    #raise @projects.inspect
  end
  
  def new
   @project = Project.new
   @employee = current_user.employee
  
  end
  
  def create
  @employee = current_user.employee
  @project = @employee.projects.create(project_params)
  @projects = @employee.projects
  end
  
  def edit
  #raise params.inspect
    @project = Project.find(params[:id])
    
  end
  
  def update
    @employee = current_user.employee
     @project = Project.find(params[:id])
     @project.update(project_params)
     @projects = @employee.projects
    
  end
  
  def destroy
  #raise params.inspect
    @project =  Project.find(params[:id])
    @project.destroy
    @projects = @employee.projects
  end
  
  
  private 
  def project_params
     params.require(:project).permit(:title, :description, :start_date, :end_date, :tasks_performed, :skills, :roles) 
  end
  
end




