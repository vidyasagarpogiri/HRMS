class SalaryIncrementsController<Controller                                                               
  
  before_filter :hr_view,  only: ["new", "edit"]
  before_filter :other_emp_view
  
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
    # redirect_to employee_salary_path(@employee, @salary)
  end                          
                                          
  def edit
    @employee= Employee.find(params[:employee_id])
    @salary = Salary.find(params[:salary_id])
    @salary_increment = SalaryIncrement.find(params[:id])
  end
     
  def update                                  
    @employee= Employee.find(params[:employee_id])              
    @salary = Salary.find(params[:salary_id])                                                                                      
    @salary_increment = SalaryIncrement.find(params[:id])       
    @salary_increment.update(params.require(:salary_increment).permit(:increment_date, :increment_value))
    redirect_to employee_salaries_path(@employee)             
  end     

  def destroy	
    @employee= Employee.find(params[:employee_id])
    @salary = Salary.find(params[:salary_id])
    @salary_increment = SalaryIncrement.find(params[:id])
    @salary_increment.destroy
    redirect_to employee_salaries_path(@employee)
  end
  
   
   
 private
  def params_salary_increment
    params.require(:salary_increment).permit(:increment_date, :increment_value).merge(:salary_id => params[:salary_id])
  end
  
end
