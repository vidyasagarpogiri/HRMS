class PayrollsController < ApplicationController
  include ApplicationHelper
  before_filter :accountant_view, only: [:pay_roll_generation, :generated_payroll, :payroll, :edit_payroll, :update_payroll, :show_payroll, :exporting_payslips_excel_sheet]
  before_filter :payslip_view, only: [:monthly_payslip_view]
  # call back for calculate default month and year
  before_action :find_month_and_year, only: [:pay_roll_generation, :generated_payroll, :payroll, :payslips_pdf]
  # PAYSLIP GENERATION  this action will generate payslips and display payslips
  def pay_roll_generation
    @payslips = Payslip.where(month: @month, year: @year)
    unless @payslips.present?
      @salary_percentages = StaticSalary.all
      @employees = Employee.where.not(status: true, salary_id: nil)
      @actual_days = Time.days_in_month(@month, @year)
      @payslips = Payslip.new.generating_payslips(@salary_percentages, @employees, @month, @year)
      @company_payroll = CompanyPayRollMaster.create(month: Date::MONTHNAMES[@month], year: @year, status: CompanyPayRollMaster::GENERATED, name: current_user.employee.full_name)
      #@cprm = CompanyPayRollMaster.where(month: enter_month, year: @year)
    end
  end

  def generated_payroll
    # BY SEARCH BY MONTH AND YEAR this action will display all generated payslips and have a option to view previous payslips
    enter_month = params[:payslip_view_month]
    enter_year = params[:payslip_view_year].to_i
    @cprm = CompanyPayRollMaster.where(month: enter_month, year: @year)
    @years = CompanyPayRollMaster.pluck(:year).uniq
    if params[:payslip_view_year] == '0' || params[:payslip_view_month] == '0'
      @error = 'Please Enter Month and Year'
      @cprm = true
    else
      month = Date::MONTHNAMES.index(enter_month)
      @payslips = Payslip.where(month: month, year: enter_year)
      @payroll_last  = CompanyPayRollMaster.where(month: enter_month, year: enter_year).first
    end
  end

  # default view of payroll // this is default view when we click on view button
  def payroll
    @month_name = Date::MONTHNAMES[@month]
    @cprm = CompanyPayRollMaster.where(month: @month_name, year: @year)
    @years = CompanyPayRollMaster.pluck(:year).uniq
    @payroll_last  = @cprm.first
    @payslips = Payslip.where(month: @month, year: @year)
  end

  def edit_payroll # action for edit indivisual payslip
    @payslip = Payslip.find(params[:id])
    @payslip_allowances = @payslip.allowances
  end

  def update_payroll
  #raise params.inspect
    @mode = params[:mode_value]
    @payslip = Payslip.find(params[:id])
    @salary = @payslip.employee.salary
    @payslip_allowances = @payslip.allowances
    @salary_percentages = StaticSalary.all
    @payslip.update(arrears: params[:arrears], pt: params[:pt],  working_days: params[:working_days], deductible_arrears: params[:deductible_arrears])
    @payslip = Payslip.new.updating_payslip(@payslip, @salary_percentages, @mode, params[:tds])
  end

  def show_payroll
    @payslip = Payslip.find(params[:id])
  end

  # action for Exporting Excel sheet
  def exporting_payslips_excel_sheet
    @month = params[:month].to_i
    @year = params[:year].to_i
    @month_name = Date::MONTHNAMES[@month]
    employee_basic_array = ['SL #', 'MONTH', 'Emp. NAME', 'DOJ', 'STATUS', 'DESIGNATION', 'DEPARTMENT']
    salary_array = ['GROSS', 'Per Month', 'Actual Per Month', 'Actual Days', 'Working Days', 'BASIC', 'HRA']
    non_deductable_allowances_array = StaticAllowance.where(is_deductable: false).pluck(:name)
    other_salary_array = ['Spcl Allowance', 'Arrears', 'Gross Pay']
    deducations = ['PF', 'ESIC', 'PT', 'TDS', 'Deductible Arrears']
    deductable_allowances_array = StaticAllowance.where(is_deductable: true).pluck(:name)
    netpay_array = ['total_deducations', 'NetPay']
    total_array = [employee_basic_array, salary_array, non_deductable_allowances_array, other_salary_array, deducations, deductable_allowances_array, netpay_array]
    total_array.flatten!
    
    @package = Axlsx::Package.new
    @workbook = @package.workbook
    @payslips = Payslip.where(month: @month,year: @year)
    @workbook.add_worksheet(name: 'Payslips') do |sheet|
      sheet.add_row total_array
      i = 1
      @payslips.each do |payslip|
      employee = payslip.employee
      designation = employee.designation.present? ? employee.designation.designation_name : " "
      department = employee.department.present? ? employee.department.department_name: " "
      salary = payslip.employee.salary
        a = [i, "#{payslip.month}-#{payslip.year}", employee.full_name, employee.date_of_join, employee.employment_status,  designation, department, salary.gross_salary, salary.gross_salary / 12, payslip.gross_salary, payslip.no_of_working_days, payslip.working_days, payslip.basic_salary, payslip.hra]
        b = []
        non_deductable_allowances_array.each do |allowance|
          c = 0
          payslip.allowances.where(is_deductable: false).each do |p_allowance|
            if allowance == p_allowance.allowance_name
              b << p_allowance.total_value
              c = 1
            end
          end
          b << 0 if c == 0
        end # non -deductable end
        other_salary = [payslip.special_allowance, payslip.arrears.to_f, payslip.gross_salary]
        other_deducations = [payslip.pf.to_f, payslip.esic.to_f, payslip.pt.to_f, payslip.tds.to_f, payslip.deductible_arrears.to_f]
        k = []
        deductable_allowances_array.each do |allowance|
          g = 0
          payslip.allowances.each do |p_allowance|
            if allowance == p_allowance.allowance_name
              k << (p_allowance.total_value ).round(2)
              g = 1
            end
          end
          k << 0 if g == 0
        end # non -deductable end
        last_salary_array = [payslip.total_deductions, payslip.netpay]
        total_values = [a, b, other_salary, other_deducations, k, last_salary_array].flatten!
        sheet.add_row total_values
        i += 1
      end # payslip end
    end # workbook end
    @package.serialize("#{Rails.root}/public/Payroll/#{@month_name}-#{@year}-payslips.xlsx")
    @mail = current_user.email
    Notification.send_payslip(@mail, @month_name, @year).deliver
    @payroll_status = CompanyPayRollMaster.where(month: @month_name, year: @year).first
    @payroll_status.update(status: CompanyPayRollMaster::PROCESSING)
    redirect_to payroll_path
  end

  # author: sekhar
  # this action will take month and year params from resepective link and
  # will generate payroll excel sheet for given month and year
  def bank_process
    @month = params[:month].to_i
    @year = params[:year].to_i
    @month_name = Date::MONTHNAMES[@month]
    @package = Axlsx::Package.new # will create an Axlsx package object
    @workbook = @package.workbook # will create a workbook of Alxls object
    @payslips_with_out_mode = Payslip.where(month: @month, year: @year)
    @payslips = @payslips_with_out_mode.where(mode: 'Bank')
    @workbook.add_worksheet(name: 'Bank Statement') do |sheet| # will crate a sheet in the work book
      sheet.add_row ['Account Number', 'Employee_name', 'Netpay', 'Month'] # will add a row to the sheet
      @payslips.each do |payslip|
        sheet.add_row [payslip.employee.account_number, payslip.employee.full_name, payslip.netpay, Date::MONTHNAMES[payslip.month]]
        tds = TdsCalculation .new(payslip.gross_salary, payslip.employee, payslip.tds)
        tds.tds_and_income_tax_update
      end
    end
    
    # will create and save an excel sheet with given details
    @package.serialize("#{Rails.root}/public/#{@month_name}-#{@year}-bank_statement.xlsx")
    @netpay_total = total_netpay(@payslips)
    @payroll_status = CompanyPayRollMaster.where(month: @month_name, year: @year).first
    @payroll_status.update(status: CompanyPayRollMaster::SENDTOBANK, total_netpay: @netpay_total)
    @payslips_with_out_mode.each do |payslip|
      payslip.update(status: 'PROCESS')
    end
    redirect_to payroll_path
  end

  # code for employee payslips views -sekhar
  def employee_monthly_payslips
    @years = CompanyPayRollMaster.pluck(:year).uniq
    @payslips = current_user.employee.payslips.where(status: 'PROCESS')
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
    year = params[:payslip_view_year].to_i
    if year == 0
      flash[:notice] = 'Please Enter Proper Year'
    else
      @year = year
      @payslips = Payslip.where(year: @year, employee_id: current_user.employee.id, status: 'PROCESS')
    end
  end
  # ---------------------------------------------------------
  # ------------ for json data of months ---------------------
  def get_payroll_years
    @years = CompanyPayRollMaster.pluck(:year)
    json_hash = {}
    @years.each do |year|
      json_hash[year.to_s] = CompanyPayRollMaster.where(year: year).map(&:month)
    end
    year_value = params['yr']
    @payroll_years = json_hash[year_value] if year_value.present?
    @payroll_years =  @years.uniq if !year_value.present?
    respond_to do|format|
      format.json { render json: @payroll_years }
    end
  end
  #-----------------------------------------------------------------------

  def payslips_pdf
    @payslips = Payslip.where(month: @month, year: @year)
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
        end
      end
    end
  end

  private

  # author: sekhar
  # This method will perform as a callback action after every action we mention in the call back
  # array of actions

  def find_month_and_year
    @month = DateTime.now.month - 1
    @year = DateTime.now.year
    if @month == 0
      @month = 12
      @year -= 1
    end
  end
end
