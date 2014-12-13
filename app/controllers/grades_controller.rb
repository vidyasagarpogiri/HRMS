class GradesController < ApplicationController

  before_filter :hr_view,  only: ["new", "edit"]
  before_filter :other_emp_view
  before_action :get_grade, only: [:show, :update, :edit, :destroy, :add_employees, :update_employee]
  
  def index
    @grades = Grade.all
    @designations = Designation.all    
  end

  def new
    @grade = Grade.new
  end

  def create
    @designation = Designation.find(params[:grade][:designation_id])
    @grade = @designation.grades.create(grade_params)
    redirect_to grades_path 
  end

  def show
    @employees = @grade.employees
  end

  def update
    @grade.update(grade_params)
    redirect_to grades_path 
  end
  
  def edit            
  end
  
  def destroy
		@grade.destroy
		redirect_to @grade
	end
	
  def add_employee
    @employee = Employee.all
  end
  
   def update_employee
    @employee = Employee.find(params[:employee_id])
    @employee.update(:grade_id => @grade.id)
    redirect_to @grade
   end 
  
  private
  def grade_params
    params.require(:grade).permit(:value) 
  end
  def get_grade
    @grade = Grade.find(params[:id])
  end
end

