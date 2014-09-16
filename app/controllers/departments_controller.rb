class DepartmentsController < ApplicationController
 layout "leave_template"
 
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
		@holiday_calender = @department.events
		#raise @holiday_calender.inspect
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
    #raise @dept.inspect
    @employees = @dept.employees
    #raise @employees.inspect
    @leaves = @employees.map(&:leave_histories).flatten if @employees.present?
   
    #raise @leaves.flatten.inspect
    #-------TODO--------#
    #Here @leaves object is depatrment all Employee leaves of array tpye pasrse it in employee_leaves view page..BY:GPR###
    #raise @leaves[1][1]['employee_id'].inspect
  end
  

  private
  def department_params
    params.require(:department).permit(:department_name) 
  end
end
