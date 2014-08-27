class SalariesController < ApplicationController
  def new
    @salary = Salary.new
    @employee = Employee.find(params[:employee_id])
  end
  
  def create
  #raise params.inspect
  @salary = Salary.create(params_salary)
  @salary.save
  @employee = Employee.find(params[:employee_id])
  @employee.update(:salary_id => @salary.id)
  redirect_to employee_salary_path(@employee, @salary)
  end

  def edit
  end

  def show
    #raise params.inspect
    @salary =  Salary.find(params[:id])
    
    @employee= Employee.find(params[:employee_id])
   @allowance = Allowance.new
   @insentive = Insentive.new
   @allowances = @salary.allowances
    @insentives =  @salary.insentives
  end
  
  
  private
  
  def params_salary
    params.require(:salary).permit(:ctc_fixed, :basic_salary)
  end
  
end
