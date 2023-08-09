 class SalariesController<Controller                                                                                                  
	                         
   include ApplicationHelper                                                                            
   layout "emp_profile_template", only: [:index, :new, :create, :show, :edit, :update, :configure_allowance]

   before_filter :hr_view,  only: ["new", "edit"]                     
   before_filter :other_emp_view                                                                              
                                                                       
  def new                                                                                                    
    @employee = Employee.find(params[:employee_id])                    
    @salary = Salary.new                
  end                       
                           
  def index                       
    @employee= Employee.find(params[:employee_id])
    @salary =  @employee.salary
    if @salary.present?
       @allowances = @salary.allowances
       @insentive = Insentive.new
       @salary_increment = SalaryIncrement.new                 
       @allowances = @salary.allowances
       @insentive = Insentive.new  
    else                                                           
       @salary = Salary.new
    end                                
  end                                                                               
 
  def create                                   
    @salary = Salary.new(params_salary)            
    @employee = Employee.find(params[:employee_id])
    @salary.save                                   
    @employee.update(:salary_id => @salary.id)                             
    @ctc_fixed = @salary.gross_salary.to_f + @salary.bonus.to_f+ @salary.gratuity.to_f + @salary.medical_insurance.to_f
    @salary.update(:ctc_fixed => @ctc_fixed, :basic_salary => @salary.basic)                                                                                              
    redirect_to  employee_salary_path(@employee, @salary) 
  end                                                                
                                                                                                              
  def edit                                                                                                                                                       
    @employee = Employee.find(params[:employee_id])                                                                                                                                                                                                                                                                                                                                                                                                          
    @salary = Salary.find(params[:id])                 
  end
  
  def update
    @employee = Employee.find(params[:employee_id])
    @salary = Salary.find(params[:id])
    @salary.update(params_salary)
    @ctc_fixed = @salary.gross_salary.to_f + @salary.bonus.to_f+ @salary.gratuity.to_f + @salary.medical_insurance.to_f
    @salary.update(:ctc_fixed => @ctc_fixed, :basic_salary => @salary.basic)
    redirect_to employee_salaries_path(@employee)
  end                                   

  def show
    @salary =  Salary.find(params[:id])   
    @employee= Employee.find(params[:employee_id])
    @allowance = Allowance.new
    @insentive = Insentive.new
    @salary_increment = SalaryIncrement.new
    @allowances = @salary.allowances
    @insentives =  @salary.insentives
    @salary_increments =@salary.salary_increments
  end

  def destroy
    @salary =  Salary.find(params[:id])
    @employee= Employee.find(params[:employee_id])
    @allowances = SalariesAllowance.where(:salary_id => @salary.id)
    @allowances.destroy_all
    @salary.destroy
    redirect_to employee_salaries_path(@employee)
  end
  
def configure_allowance
  @employee= Employee.find(params[:employee_id])
  @salary =  Salary.find(params[:salary_id])
  @allowances = Allowance.all
end
	
def create_allowance
	@employee= Employee.find(params[:employee_id])
	@salary =  Salary.find(params[:salary_id])
	params[:allowance_ids].each do |a|
  	SalariesAllowance.create(:salary_id => @salary.id, :allowance_id => a)
	end
	redirect_to employee_salaries_path(@employee)
end

def edit_allowance
  @employee= Employee.find(params[:employee_id])
  @salary =  Salary.find(params[:salary_id])
  @allownces = Allowance.all
end
	
def update_allowance
@employee= Employee.find(params[:employee_id])
@salary =  Salary.find(params[:salary_id])
allowances = SalariesAllowance.where(:salary_id => @salary.id)
allowances.destroy_all
params[:allowance_ids].each do |a|	
	SalariesAllowance.create(:salary_id => @salary.id, :allowance_id => a)	
end
redirect_to employee_salaries_path(@employee)
	end

def add_allowance
	@employee= Employee.find(params[:employee_id])
	@salary =  Salary.find(params[:salary_id])
	salary_allowance= @salary.allowances.map(&:allowance_name)
	respond_to do |format|
		format.js
	end
end
	
	def configure_pf
	  #raise params.inspect
	  @employee = Employee.find(params[:employee_id])
	  @salary = @employee.salary
	  if params[:Pf] == "on" && params[:Esci] == "on"
       @salary.update(:pf_apply => "true", :esic_apply => "true", :pf => @salary.pf, :esic => @salary.esic, :pf_contribution => 1200, :esic_contribution => 1000)
	  elsif params[:Pf] == "on"
	    @salary.update(:pf_apply => "true", :pf => @salary.pf, :pf_contribution => @salary.pf_contribution)
	  else
	     @salary.update(:esic_apply => "true", :esic => @salary.esic, :esic_contribution => @salary.esic_contribution )
	  end
    redirect_to employee_salaries_path(@employee)
	end
  
  private
  
  def params_salary
    params.require(:salary).permit(:gross_salary, :bonus, :gratuity, :medical_insurance)
  end


  
end
