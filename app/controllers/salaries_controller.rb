class SalariesController < ApplicationController
	include ApplicationHelper
  # layout "emp_profile_template", only: [:index, :new, :create, :show, :edit, :update, :configure_allowance]

	before_filter :hr_view,  only: ["new", "edit"]
  before_filter :other_emp_view
  before_action :salary_percentage, only: [:create, :configure_pf, :update, :edit]

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
	  @salary_percentages = StaticSalary.all
    @employee.update(:salary_id => @salary.id)
	  @ctc_fixed = @salary.gross_salary.to_f + @salary.bonus.to_f+ @salary.gratuity.to_f + @salary.medical_insurance.to_f
	  special_allowance = @salary.gross_salary.to_f - basic(@salary,@salary_percentages)
	  @salary.update(:ctc_fixed => @ctc_fixed, :basic_salary => basic(@salary,@salary_percentages), :special_allowance => special_allowance)
	  
    end

  def edit
    @employee = Employee.find(params[:employee_id])
    @salary = Salary.find(params[:id])
    @salary_percentages =  StaticSalary.all
    @allowances = @salary.allowances
  end
  
  def update

    @employee = Employee.find(params[:employee_id])
    @salary = Salary.find(params[:id])
    @allowances = @salary.allowances
    @salary_percentages =  StaticSalary.all
    
    @salary.update(:gross_salary => params[:salary][:gross_salary], :bonus => params[:salary][:bonus], :gratuity => params[:salary][:gratuity], :medical_insurance => params[:salary][:medical_insurance], :basic_salary => basic_value(params[:salary][:gross_salary],@salary_percentages))
	  if params[:Pf] == "on" && params[:esic] == "on"
      @salary.update(:pf_apply => "true", :esic_apply => "true", :pf => pf(@salary,@salary_percentages), :esic => esic(@salary,@salary_percentages), :pf_contribution => pf_contribution(@salary,@salary_percentages), :esic_contribution => esic_contribution(@salary,@salary_percentages))
     
	  elsif params[:Pf] == "on"
	    @salary.update(:pf_apply => "true", :pf => pf(@salary,@salary_percentages), :esic_apply => "false", :pf_contribution => pf_contribution(@salary,@salary_percentages), :esic => 0.0, :esic_contribution => 0.0)
	     
	  elsif params[:esic] == "on" 
	    @salary.update(:esic_apply => "true", :esic => esic(@salary,@salary_percentages), :pf_apply => "false", :esic_contribution => esic_contribution(@salary,@salary_percentages), :pf => 0.0, :pf_contribution => 0.0)
	   
	  else
	      @salary.update(:pf => 0.0, :pf_contribution => 0.0, :pf_apply => "false", :esic => 0.0, :esic_contribution => 0.0, :esic_apply => "false")
	       
	  end
     @ctc_fixed = @salary.gross_salary.to_f + @salary.bonus.to_f+ @salary.gratuity.to_f + @salary.medical_insurance.to_f + @salary.pf_contribution.to_f + @salary.esic_contribution 
    
     
    if @allowances.present?
      special_allowance = allowance_total(@allowances, @salary)
    else
		  special_allowance = @salary.gross_salary.to_f - ( basic(@salary,@salary_percentages) + @salary.esic + @salary.pf)
		end
		 @salary.update(:ctc_fixed => @ctc_fixed, :basic_salary => basic(@salary,@salary_percentages), :special_allowance => special_allowance)
  end
 
  def show
    
    @salary =  Salary.find(params[:id])   
    @employee= Employee.find(params[:employee_id])
    @allowance = Allowance.new
    @allowances = @salary.allowances
    @salary_increments =@salary.salary_increments
    @salary_percentages = StaticSalary.all
    #raise @salary_percentages.inspect
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
			@allowances = StaticAllowance.all
	end
	
	def create_allowance
	 
		@employee= Employee.find(params[:employee_id])
		@salary =  Salary.find(params[:salary_id])
		@allowance = @salary.gross_salary - @salary.basic_salary
		@allowances = @salary.allowances
		if params[:allowance_ids].present?
		params[:allowance_ids].each do |a|
		  sa = StaticAllowance.find(a)
		  Allowance.create(:salary_id => @salary.id, :allowance_name => sa.name, :value => sa.percentage, :allowance_value => sa.value )
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
			@allownaces = StaticAllowance.all
			@employee_allowances = @salary.allowances 
	end
	
	def update_allowance
		@employee= Employee.find(params[:employee_id])
		@salary =  Salary.find(params[:salary_id])
		#@allowance = @salary.gross_salary - @salary.basic_salary
		@allowances = @salary.allowances
		allowances = Allowance.where(:salary_id => @salary.id)
		allowances.destroy_all
	  if params[:allowance_ids].present? 
		  params[:allowance_ids].each do |a|	
			  sa = StaticAllowance.find(a)
		  Allowance.create(:salary_id => @salary.id, :allowance_name => sa.name, :value => sa.percentage, :allowance_value => sa.value )
		  end
		@other_allowance = allowance_total(@allowances, @salary)
		@salary.update(:special_allowance => @other_allowance )
		else
		  special_allowance = @salary.gross_salary.to_f - (@salary.basic_salary + @salary.esic + @salary.pf )
		  @salary.update(:special_allowance => special_allowance)
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
	  @salary_percentages = StaticSalary.all
	  if params[:Pf] == "on" && params[:Esci] == "on"
      @salary.update(:pf_apply => "true", :esic_apply => "true", :pf => pf(@salary,@salary_percentages), :esic => esic(@salary,@salary_percentages), :pf_contribution => pf_contribution(@salary,@salary_percentages), :esic_contribution => esic_contribution(@salary,@salary_percentages))
	  elsif params[:Pf] == "on"
	    @salary.update(:pf_apply => "true", :pf => pf(@salary,@salary_percentages), :pf_contribution => pf_contribution(@salary,@salary_percentages), :esic => 0.0, :esic_contribution => 0.0)
	  elsif params[:Esci] == "on" 
	    @salary.update(:esic_apply => "true", :esic => esic(@salary,@salary_percentages), :esic_contribution => esic_contribution(@salary,@salary_percentages), :pf => 0.0, :pf_contribution => 0.0)
	  else
	      @salary.update(:pf => 0.0, :pf_contribution => 0.0, :pf_apply => "false", :esic => 0.0, :esic_contribution => 0.0, :esic_apply => "false")
	  end
	   @ctc_fixed = @salary.gross_salary.to_f + @salary.bonus.to_f+ @salary.gratuity.to_f + @salary.medical_insurance.to_f + @salary.pf_contribution.to_f + @salary.esic_contribution 
    special_allowance = @salary.gross_salary.to_f - ( basic(@salary,@salary_percentages) + @salary.esic + @salary.pf )
	  @salary.update(:ctc_fixed => @ctc_fixed, :basic_salary => basic(@salary,@salary_percentages), :special_allowance => special_allowance)
	end
	
	def bankdetails_index
    @employee = Employee.find(params[:employee_id])
    @bank_details =  @employee.bank_detail
  end
  
  def bankdetails_new
    @employee = Employee.find(params[:employee_id])
    @bank_details = Employee.new    
  end
  
  def bankdetails_create
    @employee = Employee.find(params[:employee_id])
		@bank_details = @employee.update(bank_details)
  end
  
  def bankdetails_show
		#raise params.inspect
		@bank_details = Employee.find(params[:id])
		@employee = Employee.find(params[:employee_id])		
	end	
	
	def bankdetails_edit
		#raise params.inspect
		@employee = Employee.find(params[:employee_id])
		@bank_details = Employee.find(params[:id])
  end
	
	def bankdetails_update		
		@employee = Employee.find(params[:employee_id])
		@bank_details = Employee.find(params[:id])
    #raise @status.inspect
		if @bank_details.update(bank_details)
	     @bank_details = @employee.Employee
	  end 
	end
	
	
  private
  
  def salary_percentage
    @salary_percentages = StaticSalary.all
  end
  
  def params_salary
    params.require(:salary).permit(:gross_salary, :bonus, :gratuity, :medical_insurance)
  end

  def bank_details
    params.require(:bank_details).permit(:bank_name, :branch_name, :account_number, :pan)
  end
  
end
