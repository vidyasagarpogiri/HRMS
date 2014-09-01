class SalariesController < ApplicationController
  def new
    @salary = Salary.new
    @employee = Employee.find(params[:employee_id])
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
  @salary = Salary.create(params_salary)
  @salary.save
  @employee = Employee.find(params[:employee_id])
  @employee.update(:salary_id => @salary.id)
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
    redirect_to employee_salary_path(@employee, @salary)
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
  
  
  private
  
  def params_salary
    params.require(:salary).permit(:ctc_fixed, :basic_salary)
  end
  
end
