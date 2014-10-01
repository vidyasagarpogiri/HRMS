class SalariesController < ApplicationController
	include ApplicationHelper
  # layout "emp_profile_template", only: [:index, :new, :create, :show, :edit, :update, :configure_allowance]

	 before_filter :hr_view,  only: ["new", "edit"]
  before_filter :other_emp_view
  before_action :salary_percentage, only: [:create, :configure_pf, :update]

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
	  @salary.update(:ctc_fixed => @ctc_fixed, :basic_salary => basic(@salary,@salary_percentages))
    end

  def edit
    @employee = Employee.find(params[:employee_id])
    @salary = Salary.find(params[:id])
  end
  
  def update
    @employee = Employee.find(params[:employee_id])
    @salary = Salary.find(params[:id])
    @allowances = @salary.allowances
    @salary.update(params_salary)
		@ctc_fixed = @salary.gross_salary.to_f + @salary.bonus.to_f+ @salary.gratuity.to_f + @salary.medical_insurance.to_f
	  @salary.update(:ctc_fixed => @ctc_fixed, :basic_salary => basic(@salary,@salary_percentages))
    
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
    @salary_percentages = StaticSalary.all
  end

	def destroy
	 @employee= Employee.find(params[:employee_id])
	 @salary =Salary.find(params[:id])
	 @allowances = @salary.allowances
	 @allowances.destroy_all
	 @salary.destroy
	 @employee.update(:salary_id => nil)
	 @salary = Salary.new
  end
  
	def configure_allowance  
			@employee= Employee.find(params[:employee_id])
			@salary =  Salary.find(params[:salary_id])
			@allowances = Allowance.all
	end
	
	def create_allowance
		@employee= Employee.find(params[:employee_id])
		@salary =  Salary.find(params[:salary_id])
		@allowance = @salary.gross_salary - @salary.basic_salary
		@allowances = @salary.allowances
		if params[:allowance_ids].present?
		params[:allowance_ids].each do |a|
		  SalariesAllowance.create(:salary_id => @salary.id, :allowance_id => a)
		end
		@other_allowance = allowance_total(@allowances, @salary)
		@salary.update(:special_allowance => @other_allowance )
		else
		  @salary.update(:special_allowance => @allowance )
		end
	end

	def edit_allowance
			@employee= Employee.find(params[:employee_id])
			@salary =  Salary.find(params[:salary_id])
			@allownaces = Allowance.all
	end
	
	def update_allowance
		@employee= Employee.find(params[:employee_id])
		@salary =  Salary.find(params[:salary_id])
		@allowance = @salary.gross_salary - @salary.basic_salary
		@allowances = @salary.allowances
		allowances = SalariesAllowance.where(:salary_id => @salary.id)
		allowances.destroy_all
	  if params[:allowance_ids].present? 
		  params[:allowance_ids].each do |a|	
			  SalariesAllowance.create(:salary_id => @salary.id, :allowance_id => a)	
		  end
		@other_allowance = allowance_total(@allowances, @salary)
		@salary.update(:special_allowance => @other_allowance )
		else
		  @salary.update(:special_allowance => @allowance )
		end
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
	  @employee = Employee.find(params[:employee_id])
	  @salary = Salary.find(params[:salary_id])
	  @allowances = @salary.allowances
	  if params[:Pf] == "on" && params[:Esci] == "on"
      @salary.update(:pf_apply => "true", :esic_apply => "true", :pf => pf(@salary,@salary_percentages), :esic => esic(@salary,@salary_percentages), :pf_contribution => pf_contribution(@salary,@salary_percentages), :esic_contribution => esic_contribution(@salary,@salary_percentages))
	  elsif params[:Pf] == "on"
	    @salary.update(:pf_apply => "true", :pf => pf(@salary,@salary_percentages), :pf_contribution => pf_contribution(@salary,@salary_percentages))
	  elsif params[:Esci] == "on" 
	    @salary.update(:esic_apply => "true", :esic => esic(@salary,@salary_percentages), :esic_contribution => esic_contribution(@salary,@salary_percentages))
	  else
	    @salary.update(:pf_apply => nil, :esic_apply => nil )
	  end
	end
  
  private
  
  def salary_percentage
    @salary_percentages = StaticSalary.all
  end
  
  def params_salary
    params.require(:salary).permit(:gross_salary, :bonus, :gratuity, :medical_insurance)
  end


  
end
