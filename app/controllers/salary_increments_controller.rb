class SalaryIncrementsController < ApplicationController

  def index
  @salary = Salary.find(params[:salary_id])
  @salary_increment = @salary.salary_increments
  end
  
  def new
  
  @employee= Employee.find(params[:employee_id])
   @salary = Salary.find(params[:salary_id])
   @salary_increment = SalaryIncrement.new
  end
  
  def create
    @form_type = params[:commit]
    @salary_increment1 = SalaryIncrement.create(params_salary_increment)
    @salary_increment1.save
    @employee= Employee.find(params[:employee_id])
    @salary = Salary.find(params[:salary_id])
    @salary_increments = @salary.salary_increments       
    @salary_increment = SalaryIncrement.new
    #redirect_to employee_salary_path(@employee, @salary)
  end
  
  def edit
  end
  
   
 private
   
  def params_salary_increment
    params.require(:salary_increment).permit(:increment_date, :increment_value).merge(:salary_id => params[:salary_id])
  end
  
end
