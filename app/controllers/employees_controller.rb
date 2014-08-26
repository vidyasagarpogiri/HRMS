class EmployeesController < ApplicationController
  def index
  end

 

  def new
    @employee = Employee.new
    
  end
  
  def create
    #raise params.inspect
    #raise current_user .inspect
    @employee = Employee.create(params_employees) 
    redirect_to @employee
  end

  def show
    @employee = Employee.find(params[:id])
  end
  
  def edit
  end  
  
  private
   
  
  
  def params_employees
    params.require(:employee).permit(:employee_id, :title, :first_name, :last_name, :date_of_birth, :gender, :marital_status, :total_experience, :status, :mobile_number, :father_name, :pan, :date_of_confirmation, :date_of_join, :date_of_exit, :department_id, :blood_group_id, :ff_status_id, :designation_id, :grade_id)
  end
end
