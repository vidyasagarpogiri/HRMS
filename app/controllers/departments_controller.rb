class DepartmentsController < ApplicationController

  def index
    @departments = Department.all
  end

  def new
    @department = Department.new
  end

  def create
    @department = Department.create(department_params)
    redirect_to @department
  end

  def show
    @department = Department.find(params[:id])
    @employees = @department.employees
  end

  def update
    @department = Department.find(params[:id])
    @department.update(department_params)
    redirect_to @department
  end
  
  def edit     
    @department = Department.find(params[:id])        
  end
  
  def destroy
	  @department = Department.find(params[:id])
		@department.destroy
		redirect_to @department
	end
	
    
  private
  def department_params
    params.require(:department).permit(:department_name) 
  end
end
