class ProjectsController < ApplicationController
  
  
  def index
     @projects = current_user.employee.projects
    #raise @projects.inspect
  end
  
  def new
   @project = Project.new
  
  
  end
  
  def create
  #raise params.inspect
  @employee = current_user.employee
  @project = @employee.projects.create(project_params)
 # @project.update(:skills => params[:total_tags].chop)
  @projects = @employee.projects
  end
  
  def edit
  #raise params.inspect
    @project = Project.find(params[:id])
    
  end
  
  def update
  #raise params.inspect
    @employee = current_user.employee
     @project = Project.find(params[:id])
     @project.update(project_params)
    # @project.update(:skills => params[:total_tags])
     @projects = @employee.projects
    
  end
  
  def destroy
  #raise params.inspect
    @project =  Project.find(params[:id])
    @project.destroy
     @projects = current_user.employee.projects
     @employee = current_user.employee
  end
  
  
  private 
  def project_params
     params.require(:project).permit(:title, :description, :start_date, :end_date, :tasks_performed, :roles, :skills) 
  end
  
end




