class PayrollsController < ApplicationController
  include ApplicationHelper
  
   #PAYSLIP GENERATION  this action will generate payslips and display payslips 
  def pay_roll_generation	
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
	                  @payslip_pf = nil
	                end
	                if @salary.esic_apply == "true"
	                  @payslip_esic = payslip_esic_value(@gross, @salary_percentages)
	                else
	                  @payslip_esic = nil
	                end
	                @total_deducted_allowances_value = deducted_allowances_total(@payslip)
	                @total_deductions = @payslip_pf.to_f + @payslip_esic.to_f + @total_deducted_allowances_value #TODO need add PT and TDS
	                @net_pay = @gross - @total_deductions #TODO We have to remove all deduable allowances from here. 
	                @payslip.update(total_deductions: @total_deductions, netpay: @net_pay, gross_salary: @gross, pf: @payslip_pf, esic: @payslip_esic, special_allowance: @payslip_special_allowance, :mode => "Bank")
                end
            end 
            @payslips = Payslip.where(:month => @month ,:year => @year)
            @company_payroll = CompanyPayRollMaster.create(:month => Date::MONTHNAMES[@month], :year => @year, :status => CompanyPayRollMaster::GENERATED, :name => current_user.employee.full_name)
        end  
  end
  
  def generated_payroll
      #BY SEARCH BY MONTH AND YEAR this action will display all generated payslips and have a option to view previous payslips
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
	
	# default view of payroll // this is default view when we click on view button 	  
	  def payroll
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
	  
	  def edit_payroll # action for edit indivisual payslip
	    @payslip = Payslip.find(params[:id])
	    @payslip_allowances = @payslip.allowances
	  end
	  
	  def update_payroll
	   @mode = params[:mode_value]
	   @payslip = Payslip.find(params[:id]) 
	   @salary = @payslip.employee.salary
	   @payslip_allowances = @payslip.allowances
	   @salary_percentages = StaticSalary.all
	   @payslip.update(:arrears => params[:arrears], :pt => params[:pt] , :tds => params[:tds], :working_days => params[:working_days])
	   @payslip_special_allowance = (@payslip.employee.salary.special_allowance/12).round(2)
	   @basic_salary = payslip_basic(((@payslip.employee.salary.basic_salary)/12).round(2), @payslip.working_days, @payslip.no_of_working_days)
	   @payslip.update(:basic_salary => @basic_salary)
	   @gross = @basic_salary + @payslip.payslip_allowances_total_value + @payslip_special_allowance + @payslip.arrears.to_f  #TODO need arrears add to below forumla
	   if @salary.pf_apply == "true"
	     @payslip_pf = payslip_pf_value(@payslip.basic_salary, @salary_percentages)
	   else
	     @payslip_pf = nil
	  end
	  if @salary.esic_apply == "true"
	     @payslip_esic = payslip_esic_value(@gross, @salary_percentages)
	  else
	     @payslip_esic = nil
	  end
	  @total_deducted_allowances_value = deducted_allowances_total(@payslip)
	  @total_deductions = @payslip_pf.to_f + @payslip_esic.to_f + @total_deducted_allowances_value + @payslip.pt.to_f + @payslip.tds.to_f
	  @net_pay = @gross - @total_deductions #TODO We have to remove all deduable allowances from here. 
	  @payslip.update(total_deductions: @total_deductions, netpay: @net_pay, gross_salary: @gross, pf: @payslip_pf, esic: @payslip_esic, special_allowance: @payslip_special_allowance, mode: @mode)
	  end
	  
	  def show_payroll
	    @payslip = Payslip.find(params[:id])
	  end
	  
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
        payslip.allowances.each do |p_allowance|
          if allowance == p_allowance.allowance_name
            k << (p_allowance.allowance_value/12).round(2)
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
    @package.serialize("#{Rails.root}/public/Payroll/#{@month_name}-#{@year}-payslips.xlsx")
    @mail = current_user.email
    Notification.send_payslip(@mail,@month_name,@year).deliver
    @payroll_status = CompanyPayRollMaster.where(:month => @month_name, :year => @year).first
    @payroll_status.update(:status => CompanyPayRollMaster::PROCESSING)
    redirect_to payroll_path
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
    @payslips_with_out_mode = Payslip.where(:month => @month, :year => @year)
    @payslips = @payslips_with_out_mode.where(:mode => "Bank")
    @workbook.add_worksheet(name: "Bank Statement") do |sheet| # will crate a sheet in the work book
      sheet.add_row ["Account Number", "Employee_name","Netpay","Month"] # will add a row to the sheet
      @payslips.each do |payslip|
        sheet.add_row [payslip.employee.account_number, payslip.employee.full_name, payslip.netpay,Date::MONTHNAMES[payslip.month]]
      end
    end
    @package.serialize("#{Rails.root}/public/#{@month_name}-#{@year}-bank_statement.xlsx") #will create and save an excel sheet with given details
    @netpay_total = total_netpay(@payslips)
    @payroll_status = CompanyPayRollMaster.where(:month => @month_name, :year => @year).first
    @payroll_status.update(:status => CompanyPayRollMaster::SENDTOBANK, :total_netpay => @netpay_total)
    @payslips_with_out_mode.each do |payslip|
      payslip.update(:status => "PROCESS")
    end
    redirect_to payroll_path
  end
  
  # code for employee payslips views -sekhar
  def employee_monthly_payslips
    @years = CompanyPayRollMaster.pluck(:year).uniq
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
  @years = CompanyPayRollMaster.pluck(:year)
    unless params[:payslip_view_year].to_i == 0
      @year = params[:payslip_view_year].to_i
      @payslips = Payslip.where(:year => @year, :employee_id => current_user.employee.id, :status => "PROCESS")
    else
      flash[:notice] = "Please Enter Proper Year"
    end
  end
  #---------------------------------------------------------
 #------------ for json data of months --------------------- 
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
#-----------------------------------------------------------------------

	def payslips_pdf
	  @month = DateTime.now.month-1
	  @year = DateTime.now.year
	  if @month == 0
	    @month = 12
	    @year = @year - 1 
	  end
	  @payslips = Payslip.where(:month => @month ,:year => @year)
	  @payslips.each do |payslip| 
	    file_path = "#{Rails.root}/public/PAYSLIPS/#{payslip.year}/#{payslip.month}"
      unless File.exist?(file_path)
        FileUtils.mkdir_p file_path 
      end 
      
      respond_to do |format|
        format.html
        format.pdf do
          pdf = ReportPdf.new(payslip)
          pdf.render_file File.join(file_path, "#{payslip.employee.id}.pdf")
          raise File.join(file_path, "#{payslip.employee.id}.pdf").inspect
        end
      end
	  end
	end
  
end
