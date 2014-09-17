class SalariesController < ApplicationController
	include ApplicationHelper
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
<<<<<<< HEAD
=======
    @allowances = @salary.allowances
		#raise @allowances.inspect
    @insentive = Insentive.new
    @salary_increment = SalaryIncrement.new
>>>>>>> e7b0d4a747334f93108754c790fe10de36dc057b
    @allowances = @salary.allowances
		#raise @allowances.inspect
    #@insentive = Insentive.new
    #@salary_increment = SalaryIncrement.new
    #@allowances = @salary.allowances
    #@insentives =  @salary.insentives
    #@salary_increments =@salary.salary_increments
   
    else
<<<<<<< HEAD
       @salary = Salary.new
=======
       #@salary = Salary.new
>>>>>>> e7b0d4a747334f93108754c790fe10de36dc057b
    end
   
  end
  
  def create
  #raise params.inspect
  @salary = Salary.new(params_salary)
	

  @employee = Employee.find(params[:employee_id])
	@salary.save
  @employee.update(:salary_id => @salary.id)
	@ctc_fixed = @salary.gross_salary.to_f + @salary.bonus.to_f+ @salary.gratuity.to_f + @salary.medical_insurance.to_f
	#raise @ctc_fixed.inspect
	@salary.update(:ctc_fixed => @ctc_fixed)
  redirect_to  employee_salaries_path(@employee)
	
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
	#raise @ctc_fixed.inspect
	@salary.update(:ctc_fixed => @ctc_fixed)
		#raise @salary.inspect
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
  
	def configure_allowance
			#raise params.inspect
			@employee= Employee.find(params[:employee_id])
			@salary =  Salary.find(params[:salary_id])
	 		
			@static_allowance = StaticAllowance.all
	end
	
	def create_allowance
		#raise params.inspect
		@employee= Employee.find(params[:employee_id])
		@salary =  Salary.find(params[:salary_id])
		params[:allowances].each do |a|
#raise a[1][:applicable].inspect
			if a[1][:applicable] == "1" 
#raise params.inspect
		 		Allowance.create(:allowance_name => a[1][:allowance_name], :value => a[1][:percentage], :applicable => a[1][:applicable], :salary_id => @salary.id)
			end
		end
		redirect_to employee_salary_path(@employee,@salary)
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
