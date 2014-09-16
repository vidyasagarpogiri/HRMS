class SalariesController < ApplicationController

   layout "emp_profile_template", only: [:index, :new, :create, :show, :edit, :update]

		before_filter :user_authentication, only: [:index, :new, :create, :show, :edit, :update]
   
  def new
		@employee = Employee.find(params[:employee_id])
    @salary = Salary.new
    
  end
  
  def index
    @employee= Employee.find(params[:employee_id])
    @salary =  @employee.salary
    if @salary.present?
       @allowance = Allowance.new
    @insentive = Insentive.new
    @salary_increment = SalaryIncrement.new
    @allowances = @salary.allowances
    @insentives =  @salary.insentives
    @salary_increments =@salary.salary_increments
   
    else
       @salary = Salary.new
    end
   
  end
  
  def create
  #raise params.inspect
  @salary = Salary.new(params_salary)
	

  @employee = Employee.find(params[:employee_id])
	if @salary.save
  @employee.update(:salary_id => @salary.id)
	@ctc_fixed = @salary.gross_salary.to_f + @salary.bonus.to_f+ @salary.gratuity.to_f + @salary.medical_insurance.to_f
	#raise @ctc_fixed.inspect
	@salary.update(:ctc_fixed => @ctc_fixed)
  redirect_to  employee_salaries_path(@employee)
	else
		render 'new'
  end
end

  def edit
    @employee = Employee.find(params[:employee_id])
    @salary = Salary.find(params[:id])
  end
  
  def update
    @employee = Employee.find(params[:employee_id])
    @salary = Salary.find(params[:id])
    @salary.update(params_salary)
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
		@salary.destroy
		redirect_to employee_salaries_path(@employee)
		
  end
  
  
  private
  
  def params_salary
    params.require(:salary).permit(:gross_salary, :bonus, :gratuity, :medical_insurance)
  end

#	private
	def user_authentication	
			@employee = Employee.find(params[:employee_id])
			#raise @employee.inspect
		if current_user.employee.employee_id  == @employee.employee_id || current_user.employee.role_id == 2
		else
			redirect_to employees_path
		end
	end
  
end
