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
  
  @form_type = params[:commit]
  @allowance1 = Allowance.create(params_allowance)
  @allowance1.save
  @employee= Employee.find(params[:employee_id])
  @salary = Salary.find(params[:salary_id])
  @allowances = @salary.allowances
   @allowance = Allowance.new
  #redirect_to employee_salary_path(@employee, @salary)
 end
 
 def show
 end
 
 private
   
  def params_allowance
    params.require(:allowance).permit(:allowance_name, :value).merge(:salary_id => params[:salary_id])
  end
  
  
end
