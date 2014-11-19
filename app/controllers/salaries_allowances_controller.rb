class SalariesAllowancesController < ApplicationController
  # will configure all allowances to a particular salary
  include ApplicationHelper
  before_action :get_employee, only: [:new, :create, :edit_allowance, :update_allowance]
  #before_action :get_salary, only: [:new, :create, :edit_allowance, :update_allowance]
  
  def new 
    @salary =  Salary.find(params[:salary_id])
    @allowances = StaticAllowance.all
  end
  
  # will create allowances which are configure for particular salary
  def create
   @salary =  Salary.find(params[:salary_id]) 
   @salary = allowance_create_or_update(params[:allowance_ids], @salary) if params[:allowance_ids].present?
  end
  
  def edit_allowance
    @salary =  Salary.find(params[:salary_id])
    @allownaces = StaticAllowance.all
	  @employee_allowances = @salary.allowances 
  end
  
  def update_allowance
    @salary =  Salary.find(params[:salary_id])
    allowances = Allowance.where(:salary_id => @salary.id)
		allowances.destroy_all
		if params[:allowance_ids].present?
		  @salary = allowance_create_or_update(params[:allowance_ids], @salary) 
		else
		  @salary.update(:special_allowance => @salary.gross_salary - (@salary.basic_salary + @salary.pf.to_f + @salary.esic.to_f + @salary.hra.to_f))
		end 
		
  end
  
  
  # private methods
  private
  
  
  def allowance_create_or_update(allowances = nil, salary)
     allowances.each do |allowance|
        staic_allowance = StaticAllowance.find(allowance)
            total_value = allowance_value(staic_allowance.percentage, salary.basic_salary).round(2) if staic_allowance.percentage 
            salary.allowances.create( :allowance_name => staic_allowance.name, :value => staic_allowance.percentage, :allowance_value => staic_allowance.value, :is_deductable => staic_allowance.is_deductable, :total_value => total_value || staic_allowance.value) 
      end    
		 @salary.update(:special_allowance => salary.gross_salary - (salary.basic_salary + salary.pf.to_f + salary.esic.to_f + salary.hra.to_f + allowance_total_by_salary(salary)))
    salary
  end 
  
  def get_employee
     @employee = Employee.find(params[:employee_id])
  end
  
  def get_salary
    @salary =  Salary.find(params[:salary_id]) 
  end
end
