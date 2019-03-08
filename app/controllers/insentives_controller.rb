class InsentivesController < ApplicationController
	
  before_filter :hr_view,  only: ["new", "edit"]                                
                                                                          
  before_filter :other_emp_view                                                                                                                       
                                                                                                                                                                                                                                                                          
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
  # raise params.inspect                             
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
  redirect_to employee_salaries_path(@employee)
 end

 def destroy
 @employee= Employee.find(params[:employee_id])
  @salary = Salary.find(params[:salary_id])
  @insentive = Insentive.find(params[:id])
	@insentive.destroy
	redirect_to employee_salaries_path(@employee)
	end
 
 private
              
  def params_insentive
    params.require(:insentive).permit(:insentive_type, :value).merge(:salary_id => params[:salary_id])
  end
  
  
end
