class InsentivesController < ApplicationController
  layout "profile_template", only: [:index, :new, :create, :show, :update, :edit]
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
 @form_type = params[:commit]
  @insentive1 = Insentive.create(params_insentive)
  @insentive1.save
   @salary = Salary.find(params[:salary_id])
   @insentives =  @salary.insentives
  @employee= Employee.find(params[:employee_id])
  @insentive = Insentive.new
 
 # redirect_to employee_salary_path(@employee, @salary)
 end
 
 def show
 end
 
 def edit
  @employee= Employee.find(params[:employee_id])
  @salary = Salary.find(params[:salary_id])
  @insentive = Insentive.find(params[:id])
 end
 
 def update
  @employee= Employee.find(params[:employee_id])
  @salary = Salary.find(params[:salary_id])
  @insentive = Insentive.find(params[:id])
  @insentive.update(params.require(:insentive).permit(:insentive_type, :value))
  redirect_to employee_salary_path(@employee, @salary)
 end
 
 
 private
   
  def params_insentive
    params.require(:insentive).permit(:insentive_type, :value).merge(:salary_id => params[:salary_id])
  end
  
  
end
