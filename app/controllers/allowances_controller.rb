class AllowancesController < ApplicationController

 def index
  #raise params.inspect
  
  @salary = Salary.find(params[:salary_id])
  @allowance = @salary.allowances
 end
 
 def new
 #raise params.inspect
   @employee= Employee.find(params[:employee_id])
   @salary = Salary.find(params[:salary_id])
   @allowance = Allowance.new
 end
 
 def create
 #raise params.inspect
  @allowance = Allowance.create(params_allowance)
  @allowance.save
  @employee= Employee.find(params[:employee_id])
  @salary = Salary.find(params[:salary_id])
  redirect_to employee_salary_path(@employee, @salary)
 end
 
 def show
 end
 
 private
   
  def params_allowance
    params.require(:allowance).permit(:allowance_name, :value).merge(:salary_id => params[:salary_id])
  end
  
  
end
