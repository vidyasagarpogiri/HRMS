class SalariesController < ApplicationController
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
		#raise @allowances.inspect
    @insentive = Insentive.new
    @salary_increment = SalaryIncrement.new

    @allowances = @salary.allowances
		#raise @allowances.inspect
    @insentive = Insentive.new
    #@salary_increment = SalaryIncrement.new
    #@allowances = @salary.allowances
    #@insentives =  @salary.insentives
    #@salary_increments =@salary.salary_increments
   
    else

       @salary = Salary.new

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

	def edit_allowance
			@employee= Employee.find(params[:employee_id])
			@salary =  Salary.find(params[:salary_id])
			@allownces = @salary.allowances
			#raise @allownces.inspect
	end
	
	def update_allowance
		#raise params.inspect
		@employee= Employee.find(params[:employee_id])
		@salary =  Salary.find(params[:salary_id])
		params[:allowances].each do |a|
		#raise a[1][:applicable].inspect
		@allowance = Allowance.find(a[0])
		if a[1][:applicable] == "1"
				@allowance.update(:allowance_name => a[1][:allowance_name], :value => a[1][:value])
		else
				@allowance.destroy
		end
			
		end
		redirect_to employee_salaries_path(@employee)
	end
	def add_allowance
		@employee= Employee.find(params[:employee_id])
		@salary =  Salary.find(params[:salary_id])
		

		salary_allowance= @salary.allowances.map(&:allowance_name)
		static_allowance = StaticAllowance.all.map(&:allowance_name)
		remaining_allowance = static_allowance - salary_allowance
		@static_allowances = []
		remaining_allowance.each do |allowance|
			@static_allowances << StaticAllowance.find_by_allowance_name(allowance)
		end
	
		respond_to do |format|
			format.js
		end
	end
  
  private
  
  def params_salary
    params.require(:salary).permit(:gross_salary, :bonus, :gratuity, :medical_insurance)
  end


  
end
