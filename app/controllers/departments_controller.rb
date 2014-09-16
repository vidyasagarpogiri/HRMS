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
		@leave_policy = @department.leave_policy 
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
	
	def add_employee
    @department = Department.find(params[:id])
    @employee = Employee.all
  end
   def update_employee
    @department = Department.find(params[:id])
    @employee = Employee.find(params[:employee_id])
    @employee.update(:department_id => @department.id)
    #raise @employee.inspect
    redirect_to @department
   end 
   
  def employee_leaves
    @dept = Department.find(params[:id])
    @employees = @dept.employees
  end
  
   
  private
  def department_params
    params.require(:department).permit(:department_name) 
  end
end
