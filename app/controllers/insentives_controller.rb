class InsentivesController < ApplicationController
def index
  #raise params.inspect
  
  @salary = Salary.find(params[:salary_id])
  @insentive = @salary.insentives
 end
 
 def new
 #raise params.inspect
   @employee= Employee.find(params[:employee_id])
   @salary = Salary.find(params[:salary_id])
   @insentive = Insentive.new
 end
 
 def create
 #raise params.inspect
  @insentive = Insentive.create(params_insentive)
  @insentive.save
  @employee= Employee.find(params[:employee_id])
  @salary = Salary.find(params[:salary_id])
  redirect_to employee_salary_path(@employee, @salary)
 end
 
 def show
 end
 
 private
   
  def params_insentive
    params.require(:insentive).permit(:insentive_type, :value).merge(:salary_id => params[:salary_id])
  end
  
  
end
