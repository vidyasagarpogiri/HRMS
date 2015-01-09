class ProjectsController < ApplicationController
  
  
  def index
     @projects = current_user.employee.projects
  end
  
  def new
   @project = Project.new
  
  
  end
  
  def create
  #raise params.inspect
  @employee = current_user.employee
    if params[:check] == "on"
     @project = @employee.projects.create(project_params_without_end_date)
    else
      @project = @employee.projects.create(project_params)
    end
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
       if params[:check] == "on"
         @project.update(project_params_without_end_date)
       else
        @project.update(project_params)
       end
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
  def project_params_without_end_date
     params.require(:project).permit(:title, :description, :start_date, :tasks_performed, :roles, :skills) 
  end
end




