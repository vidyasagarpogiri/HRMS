class SalariesController < ApplicationController

   layout "profile_template", only: [:index, :new, :create, :show, :edit, :update]
   
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
    params.require(:salary).permit(:ctc_fixed, :basic_salary)
  end
  
end
