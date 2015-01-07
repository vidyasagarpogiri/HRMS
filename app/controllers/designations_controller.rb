class DesignationsController < ApplicationController
  
  before_action :find_designation, only: [:show, :edit, :update, :destroy, :add_employee, :update_employee]
 
  def index
    @designations = Designation.all
    @departments = Department.all
  end

  def new
    @designation = Designation.new
  end

  def create
    @department = Department.find(params[:designation][:department_id])
    @designation = @department.designations.create(designation_params)
    redirect_to designations_path
  end

  def show
    @employees = @designation.employees
    @grades = @designation.grades

  end

  def update
    @designation.update(designation_params)
    redirect_to designations_path
  end
  
  def edit            
  end
  
  def destroy
		@designation.destroy
		redirect_to @designation
	end
	
  def add_employee
    @employee = Employee.all
  end
  
  def update_employee
    @employee = Employee.find(params[:employee_id])
    @employee.update(:designation_id => @designation.id)
    redirect_to @designation
  end 
    
  private
  def designation_params
    params.require(:designation).permit(:designation_name, :department_id) 
  end
  def find_designation
    @designation = Designation.find(params[:id])
  end
end


