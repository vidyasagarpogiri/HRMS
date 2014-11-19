class SalariesController < ApplicationController
  include ApplicationHelper
  before_filter :hr_view,  only: [:new, :edit]
  before_action :salary_percentage, only: [:create, :configure_pf, :update, :edit]
  # before action for finding employee
  before_action :get_employee, only: [:index, :new, :create, :show, :edit, :update, :destroy, :configure_pf]
  # before action for finding salary
  before_action :get_salary, only: [:index, :edit, :update, :destroy]

  # Methods basic, allowance_total
  def new
    @employee = Employee.find(params[:employee_id])
    @salary = Salary.new
  end

  def index
    @employee = Employee.find(params[:employee_id])
    @salary = @employee.salary
  end

  def create
    @salary = @employee.create_salary(params_salary)
    @salary_percentages = StaticSalary.all
    if @salary.errors.present?
      @errors = @salary.errors
    else
      @ctc_fixed = @salary.gross_salary.to_f + @salary.bonus.to_f + @salary.gratuity.to_f + @salary.medical_insurance.to_f
      basic_salary = calculate_basic(@salary, @salary_percentages) # it will calls Application Helper
      hra = calculate_hra(basic_salary, @salary_percentages)
      special_allowance = @salary.gross_salary.to_f - (basic_salary + hra)
      @salary.update(ctc_fixed: @ctc_fixed, basic_salary: basic_salary, hra: hra, special_allowance: special_allowance)
    end
  end

  def edit
    @salary_percentages =  StaticSalary.all
    @allowances = @salary.allowances
  end

  def update
    @allowances = @salary.allowances
    @salary_percentages =  StaticSalary.all
    @salary.update(gross_salary: params[:salary][:gross_salary], bonus: params[:salary][:bonus], gratuity: params[:salary][:gratuity], medical_insurance: params[:salary][:medical_insurance], basic_salary: basic_value(params[:salary][:gross_salary], @salary_percentages))
    @salary = salary_pf_esic_apply(@salary, @salary_percentages, params[:pf], params[:esic], @allowances)
  end

  def show
    @salary =  @employee.salary
    @allowance = Allowance.new
    @allowances = @salary.allowances
    @salary_increments = @salary.salary_increments
    @salary_percentages = StaticSalary.all
  end

  def destroy
    @allowances = @salary.allowances
    @allowances.destroy_all
    @salary.destroy
    @employee.update(salary_id: nil)
    @salary = Salary.new
  end

  def configure_pf
    @salary = Salary.find(params[:salary_id])
    @salary_percentages = StaticSalary.all
    @salary = salary_pf_esic_apply(@salary, @salary_percentages, params[:pf], params[:esic])
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

  def get_employee
    @employee = Employee.find(params[:employee_id])
  end

  def get_salary
    @salary = Salary.find(params[:id])
  end

  def salary_pf_esic_apply(salary, salary_percentages, pf = nil, esic = nil, allowances = nil)
    hra = calculate_hra(salary.basic_salary, salary_percentages)
    pf_value = calculate_pf(salary, salary_percentages)
    esic_value = calculate_esic(salary, salary_percentages)
    basic_value = calculate_basic(salary, salary_percentages)
    if pf == 'on' && esic == 'on'
      salary.update(pf_apply: 'true', esic_apply: "true", pf: pf_value, esic: esic_value, hra: hra)
    elsif pf == 'on'
      salary.update(pf_apply: 'true', pf: pf_value, esic_apply: 'false', esic: 0.0, hra: hra)
    elsif esic == 'on'
      salary.update(esic_apply: 'true', esic: esic_value, pf_apply: 'false', pf: 0.0, hra: hra)
    else
      salary.update(pf: 0.0, pf_apply: 'false', esic: 0.0, esic_apply: 'false', hra: hra)
    end
    ctc_fixed = salary.gross_salary.to_f + salary.bonus.to_f + salary.gratuity.to_f + salary.medical_insurance.to_f
    if allowances.present?
      special_allowance = allowance_total(allowances, salary)
    else
      special_allowance = salary.gross_salary.to_f - (basic_value + salary.esic + salary.pf + hra)
    end
    # special_allowance = @salary.gross_salary.to_f - (basic_value + hra)
    salary.update(ctc_fixed: ctc_fixed, basic_salary: basic_value, special_allowance: special_allowance)
    salary
  end
end
