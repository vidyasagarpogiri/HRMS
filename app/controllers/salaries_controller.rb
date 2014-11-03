class SalariesController < ApplicationController
	include ApplicationHelper
  # layout "emp_profile_template", only: [:index, :new, :create, :show, :edit, :update, :configure_allowance]

	before_filter :hr_view,  only: ["new", "edit"]
	before_filter :accountant_view, only: [:pay_slips_generation, :generated_payslips, :payslips_list, :edit_payslip, :update_payslip, :show_payslip, :exporting_payslips_excel_sheet ]
  #before_filter :other_emp_view, except: [:employee_monthly_payslips, :monthly_payslip_view, :employee_payslips_by_year, :payslips_list]
  before_action :salary_percentage, only: [:create, :configure_pf, :update, :edit]
  
  before_filter :payslip_view, only: [:monthly_payslip_view]

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
	  unless @salary.errors.present? 
	    @salary_percentages = StaticSalary.all
      @employee.update(:salary_id => @salary.id)
	    @ctc_fixed = @salary.gross_salary.to_f + @salary.bonus.to_f+ @salary.gratuity.to_f + @salary.medical_insurance.to_f
	    special_allowance = @salary.gross_salary.to_f - basic(@salary,@salary_percentages)
	    @salary.update(:ctc_fixed => @ctc_fixed, :basic_salary => basic(@salary,@salary_percentages), :special_allowance => special_allowance)
	  else
	    @errors = @salary.errors
    end
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
   
    @employee= Employee.find(params[:employee_id])
    @salary =  @employee.salary
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
		# code for updation of deductable allowances -sekhar
		  sa = StaticAllowance.find(a)
		    if sa.is_deductable
		        Allowance.create(:salary_id => @salary.id, :allowance_name => sa.name, :value => sa.percentage, :allowance_value => sa.value, :is_deductable => true)
		    else
		        Allowance.create(:salary_id => @salary.id, :allowance_name => sa.name, :value => sa.percentage, :allowance_value => sa.value)
		    end
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
		@allowances = Allowance.where(:salary_id => @salary.id)
		@allowances.destroy_all
	  if params[:allowance_ids].present? 
		  params[:allowance_ids].each do |a|	
			  sa = StaticAllowance.find(a)
			  if sa.is_deductable
		          Allowance.create(:salary_id => @salary.id, :allowance_name => sa.name, :value => sa.percentage, :allowance_value => sa.value, :is_deductable => true)
		    else
		          Allowance.create(:salary_id => @salary.id, :allowance_name => sa.name, :value => sa.percentage, :allowance_value => sa.value )
		    end
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
	  # this if-else statement is to check applicability of pf and esic based on their values in the salary record
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
	

	# code for payslips genaration - sekhar
	 
  def pay_slips_generation	
  #PAYSLIP GENERATION  
    @month = DateTime.now.month-1
	  @year = DateTime.now.year
	  if @month == 0
	    @month = 12
	    @year = @year - 1 
	  end
	  @payslips = Payslip.where(:month => @month ,:year => @year)
    
    unless @payslips.present?
	    @salary_percentages = StaticSalary.all
	    @employees = Employee.where(status: false)
	    @actual_days = Time.days_in_month(@month,@year)
	          @employees.each do |employee|
	            @salary = employee.salary
	              if @salary.present?
	                payslip_basic = payslip_basic((@salary.basic_salary)/12, @actual_days, @actual_days) #have to replace first actual days to employee working days
	                @payslip = Payslip.create(:no_of_working_days => @actual_days, :working_days => @actual_days, :basic_salary => payslip_basic, :month=> @month, :year => @year, :employee_id => employee.id, :status => "NEW")
	                #for creating allowances for payslip
	                @salary.payslip_allowances(@payslip)
	                @payslip_special_allowance = (@salary.special_allowance/12).round(2)
	                @gross = @payslip.basic_salary + @payslip.payslip_allowances_total_value + @payslip_special_allowance #TODO need arrears add to below forumla       
	                if @salary.pf_apply == "true"
	                  @payslip_pf = payslip_pf_value(@payslip.basic_salary, @salary_percentages)
	                else
	                  @payslip_pf = 0.0
	                end
	                if @salary.esic_apply == "true"
	                  @payslip_esic = payslip_esic_value(@gross, @salary_percentages)
	                else
	                  @payslip_esic = 0.0
	                end
	                @total_deducted_allowances_value = deducted_allowances_total(@payslip)
	                @total_deductions = @payslip_pf + @payslip_esic + @total_deducted_allowances_value #TODO need add PT and TDS
	                @net_pay = @gross - @total_deductions #TODO We have to remove all deduable allowances from here. 
	                @payslip.update(total_deductions: @total_deductions, netpay: @net_pay, gross_salary: @gross, pf: @payslip_pf, esic: @payslip_esic, special_allowance: @payslip_special_allowance)
                end
            end 
            @payslips = Payslip.where(:month => @month ,:year => @year)
            @company_payroll = CompanyPayRollMaster.create(:month => Date::MONTHNAMES[@month], :year => @year, :status => CompanyPayRollMaster::GENERATED, :name => current_user.employee.full_name)
        else
          flash[:notice] = "You Already Generated Payslip With Given Month"
        end  
	  end
	  
	  def generated_payslips
      #BY SEARCH BY MONTH AND YEAR
	  	@month = DateTime.now.month-1
	    @year = DateTime.now.year
	    if @month == 0
	      @month = 12
	      @year = @year - 1 
	    end
	    
	    @cprm = CompanyPayRollMaster.where(month: Date::MONTHNAMES[@month], year: @year)	
	    
	    @enter_month = Date::MONTHNAMES.index(params[:payslip_view_month])
      @enter_year = params[:payslip_view_year].to_i 
	    @years = CompanyPayRollMaster.pluck(:year).uniq
	      
	    if params["payslip_view_year"] == "0" || params["payslip_view_month"] == "0"
	      @error = "Please Enter Month and Year"
	    else
	      @month_name = Date::MONTHNAMES[@enter_month]
	      @enter_year = params[:payslip_view_year].to_i
	      @payslips = Payslip.where(:month => @enter_month ,:year => @enter_year)
	      @payroll_last  = CompanyPayRollMaster.where(:month => params[:payslip_view_month], :year => @enter_year).first
	    end	
	  end
	  
	  def payslips_list
	  #BY DEFULT VIEW
	    @month = DateTime.now.month-1
	    @year = DateTime.now.year
	    if @month == 0
	      @month = 12
	      @year = @year - 1 
	    end
	    @month_name = Date::MONTHNAMES[@month]
	    @cprm = CompanyPayRollMaster.where(month: @month_name, year: @year)	   
	    @years = CompanyPayRollMaster.pluck(:year).uniq
	    @payroll_last  = CompanyPayRollMaster.where(:month => @month_name, :year => @year).first
      @payslips = Payslip.where(:month => @month ,:year => @year)
	  end
	  
	  def edit_payslip
	    @payslip = Payslip.find(params[:id])
	    @payslip_allowances = @payslip.allowances
	  end
	  
	  def update_payslip
	   @mode = params[:mode]
	   @payslip = Payslip.find(params[:id]) 
	   @salary = @payslip.employee.salary
	   @payslip_allowances = @payslip.allowances
	   @salary_percentages = StaticSalary.all
	   @payslip.update(:arrears => params[:arrears], :pt => params[:pt] , :tds => params[:tds], :working_days => params[:working_days])
	   @payslip_special_allowance = (@payslip.employee.salary.special_allowance/12).round(2)
	   @basic_salary = payslip_basic(((@payslip.employee.salary.basic_salary)/12).round(2), @payslip.working_days, @payslip.no_of_working_days)
	   @payslip.update(:basic_salary => @basic_salary)
	   #@payslip.payslip_allowance_update(@payslip)
	   @gross = @basic_salary + @payslip.payslip_allowances_total_value + @payslip_special_allowance  #TODO need arrears add to below forumla
	   if @salary.pf_apply == "true"
	     @payslip_pf = payslip_pf_value(@payslip.basic_salary, @salary_percentages)
	   else
	     @payslip_pf = 0.0
	  end
	  if @salary.esic_apply == "true"
	     @payslip_esic = payslip_esic_value(@gross, @salary_percentages)
	  else
	     @payslip_esic = 0.0
	  end
	  @total_deducted_allowances_value = deducted_allowances_total(@payslip)
	  @total_deductions = @payslip_pf + @payslip_esic + @total_deducted_allowances_value + @payslip.pt.to_f + @payslip.tds.to_f
	  @net_pay = @gross + @payslip.arrears.to_f - @total_deductions #TODO We have to remove all deduable allowances from here. 
	  @payslip.update(total_deductions: @total_deductions, netpay: @net_pay, gross_salary: @gross, pf: @payslip_pf, esic: @payslip_esic, special_allowance: @payslip_special_allowance, mode: @mode)
	  end
	  
	  def show_payslip
	    @payslip = Payslip.find(params[:id])
	  end
	#--------------------------------------
# code for employee payslips views -sekhar
  def employee_monthly_payslips
    @payslips = current_user.employee.payslips.where(:status => "PROCESS")
  end
  
  def monthly_payslip_view
    @payslip = Payslip.find(params[:id])
    respond_to do |format|
      format.html
      format.pdf do
        pdf = ReportPdf.new(@payslip)
        send_data pdf.render, filename: 'report.pdf', type: 'application/pdf'
      end
    end
    
  end
  
  def employee_payslips_by_year
    unless params[:payslip_view_year].to_i == 0
      @year = params[:payslip_view_year].to_i
      @payslips = Payslip.where(:year => @year, :employee_id => current_user.employee.id, :status => "PROCESS")
    else
      flash[:notice] = "Please Enter Proper Year"
    end
  end
  
  def get_payroll_years
    @years = CompanyPayRollMaster.pluck(:year)
    json_hash = {}
    @years.each do |year|
      json_hash[year.to_s] = CompanyPayRollMaster.where(year: year).map(&:month)
    end
    @payroll_years = json_hash[params["yr"]] if params["yr"].present?
    @payroll_years =  @years.uniq if !params["yr"].present?
    respond_to do|format|
      format.json { render json: @payroll_years }
    end
  end
#---------------------------------

# action for Exporting Excel sheet
  def exporting_payslips_excel_sheet
    @month = params[:month].to_i
    @year = params[:year].to_i

    @month_name = Date::MONTHNAMES[@month]
    
    employee_basic_array = ["SL #", "MONTH", "Emp. NAME", "DOJ", "STATUS", "DESIGNATION", "DEPARTMENT"]
    salary_array = ["GROSS", "Per Month", "Actual Per Month", "Actual Days", "Working Days", "BASIC"]
    non_deductable_allowances_array = StaticAllowance.where(is_deductable: false).pluck(:name)
    other_salary_array = ["Spcl Allowance", "Arrears", "Gross Pay"]
    deducations = ["PF", "ESIC", "PT", "TDS"]
    deductable_allowances_array = StaticAllowance.where(is_deductable: true).pluck(:name)
    netpay_array = ["total_deducations", "NetPay"]
    
    total_array = [employee_basic_array, salary_array, non_deductable_allowances_array, other_salary_array, deducations,  deductable_allowances_array, netpay_array]
    total_array.flatten!

    @package = Axlsx::Package.new
    @workbook = @package.workbook
    @payslips = Payslip.where(:month => @month, :year => @year)
    #raise @payslips.inspect
    @workbook.add_worksheet(name: "Payslips") do |sheet|
      sheet.add_row total_array
      i = 1
      
      @payslips.each do |payslip|
        a = [i, "#{payslip.month}-#{payslip.year}", payslip.employee.full_name, payslip.employee.date_of_join, payslip.employee.employment_status, payslip.employee.designation.designation_name, payslip.employee.department.department_name, payslip.employee.salary.gross_salary, payslip.employee.salary.gross_salary/12, payslip.gross_salary, payslip.no_of_working_days, payslip.working_days, payslip.basic_salary ]
        b = []
        
        non_deductable_allowances_array.each do |allowance|
          c= 0
          payslip.allowances.where(is_deductable: false).each do |p_allowance|
            if allowance == p_allowance.allowance_name
              b << p_allowance.total_value
              c = 1
            end
          end
          if c == 0
            b << 0
          end
        end #non -deductable end 
        
        other_salary = [payslip.special_allowance, payslip.arrears.to_f, payslip.gross_salary]
        other_deducations = [payslip.pf.to_f, payslip.esic.to_f, payslip.pt.to_f, payslip.tds.to_f]
        k=[]
        deductable_allowances_array.each do |allowance|
        g= 0
        payslip.allowances.where(is_deductable: true).each do |p_allowance|
          if allowance == p_allowance.allowance_name
            k << p_allowance.total_value
            g = 1
          end
        end
        if g == 0
          k << 0
        end
      end #non -deductable end 
      last_salary_array = [payslip.total_deductions, payslip.netpay]
        total_values = [a,b, other_salary, other_deducations, k, last_salary_array].flatten!
        sheet.add_row total_values
        i = i+1 
      end #payslip end
        
       
      end #workbook end
=begin
       
       #sheet.add_row 
        values_array = [payslip.employee.employee_id, payslip.employee.full_name, payslip.employee.department.department_name, payslip.basic_salary]
         if payslip.allowances.present?
          payslip.allowances.each do |allowance|
           details_array.push allowance.allowance_name
           values_array.push allowance.total_value
           sheet.add_row ["#{allowance.allowance_name}", allowance.total_value]
          end
         end
      end  
=end  

    @package.serialize("#{Rails.root}/public/PAYSLIPS/#{@month_name}-#{@year}-payslips.xlsx")
    #@package.serialize("/home/sekhar/#{@month_name}-#{@year}-bank_statement.xlsx")
    @mail = current_user.email
    Notification.send_payslip(@mail,@month_name,@year).deliver
    @payroll_status = CompanyPayRollMaster.where(:month => @month_name, :year => @year).first
    @payroll_status.update(:status => CompanyPayRollMaster::PROCESSING)
    redirect_to salaries_payslips_list_path
  end
  
  
=begin
******  sekhar *********
  this action will take month and year params from resepective link and  
  will generate payroll excel sheet for given month and year
=end  
  def bank_process
    @month = params[:month].to_i
    @year = params[:year].to_i
    @month_name = Date::MONTHNAMES[@month]
    @package = Axlsx::Package.new # will create an Axlsx package object
    @workbook = @package.workbook # will create a workbook of Alxls object
    @payslips = Payslip.where(:month => @month, :year => @year)
   # @workbook.styles do |style|
    #  center = style.add_style alignment:  {horizontal: :center}, fg_color: "0000FF", sz: 15, b: true
    @workbook.add_worksheet(name: "Bank Statement") do |sheet| # will crate a sheet in the work book
      #sheet.add_row ["Bank Details and Netpay of Employees"] , style: center
      #sheet.merge_cells "A1:F1"
      sheet.add_row ["Account Number", "Employee_name","Netpay","Month"] # will add a row to the sheet
      @payslips.each do |payslip|
        sheet.add_row [payslip.employee.account_number, payslip.employee.full_name, payslip.netpay,Date::MONTHNAMES[payslip.month]]
      end
    end
    #end
    @package.serialize("#{Rails.root}/public/#{@month_name}-#{@year}-bank_statement.xlsx") #will create and save an excel sheet with given details
    #@package.serialize("/home/sekhar/#{@month_name}-#{@year}-bank_statement.xlsx")
    @payroll_status = CompanyPayRollMaster.where(:month => @month_name, :year => @year).first
    @payroll_status.update(:status => CompanyPayRollMaster::SENDTOBANK)
    @payslips.each do |payslip|
      payslip.update(:status => "PROCESS")
    end
    redirect_to salaries_payslips_list_path
  end
#---------------------------------

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
	
	
	def payslips_pdf
	  @month = DateTime.now.month-1
	  @year = DateTime.now.year
	  if @month == 0
	    @month = 12
	    @year = @year - 1 
	  end
	  @payslips = Payslip.where(:month => @month ,:year => @year)
     respond_to do |format|
      format.html
      format.pdf do
        pdf = ReportPdf.new(@payslips)
        send_data pdf.render, filename: 'report.pdf', type: 'application/pdf'
      end
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
