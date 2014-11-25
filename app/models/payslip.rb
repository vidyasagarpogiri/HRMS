class Payslip < ActiveRecord::Base
  include ApplicationHelper
  belongs_to :employee
  has_many :allowances

  # TODO remove Payslip allowance table

  def payslip_allowances_total_value
    allowances.where(is_deductable: false).sum(:total_value).round(2)
  end
  
  def check_tds
    tds = TdsCalculation.new(9345, 2)
  end
  # begin author - sekhar
  # this code will be modified or removed depends on reqirement
  # untill don`t touch this code

=begin  --------------------------------------------
def payslip_allowance_update(payslip)
allowances.each do |allowance|
total_value = payslip_allowance_update_value(payslip, allowance)
@allowance = Allowance.where(:id => allowance.id, :payslip_id => payslip.id).first
@allowance.update(:total_value => total_value)
end
end

def payslip_allowance_update_value(payslip, allowance)
if allowance.value.present?
total_value = (payslip.basic_salary*allowance.value)/100
return total_value
else
#TODO allowance_value depends on working days and actual working days
total_value  = allowance.allowance_value
return total_value
end
end
====================================================================
=end

  # author: sekhar
  # date: 18/11/2014
  # * This method is to generate payslips and return all generated payslips
  def generating_payslips(salary_percentages, employees, month, year)
    actual_days = Time.days_in_month(month, year)
    employees.each do |employee|
      salary = employee.salary
      payslip_basic = payslip_basic((salary.basic_salary)/12, actual_days, actual_days)
      payslip_hra = monthly(salary.hra)
      payslip = Payslip.create(no_of_working_days: actual_days, working_days: actual_days, basic_salary: payslip_basic, hra: payslip_hra, month: month, year: year, employee_id: employee.id, status: 'NEW')
      # for creating allowances for payslip
      salary.payslip_allowances(payslip)
      payslip_special_allowance = (salary.special_allowance/12).round(2)
      gross = payslip.basic_salary + payslip.hra + payslip.payslip_allowances_total_value + payslip_special_allowance
      
      new_tds = TdsCalculation.new(gross, employee.id)
      tds = new_tds.tds_for_this_month
      # method call for calculation pf,esic and total_deductions
      payslip_pf_value, payslip_esic_value,total_deducted_allowances_value = caluclate_pf_and_esic_value(payslip, salary_percentages,gross)
      total_deductions_value = payslip_pf_value.to_f + payslip_esic_value.to_f + total_deducted_allowances_value + tds.to_f
      net_pay = gross - total_deductions_value
      payslip.update(total_deductions: total_deductions_value, netpay: net_pay, gross_salary: gross, pf: payslip_pf_value, esic: payslip_esic_value, special_allowance: payslip_special_allowance, mode: 'Bank', tds: tds)
    end
    payslips = Payslip.where(month: month, year: year)
  end

  # author: sekhar
  # date: 18/11/2014
  # * This method is to update payslip and return payslip to controller
  def updating_payslip(payslip, salary_percentages, mode)
    salary = payslip.employee.salary
    basic_salary = payslip_basic(((salary.basic_salary)/12).round(2), payslip.working_days, payslip.no_of_working_days)
    payslip.update(:basic_salary => basic_salary)
    payslip_special_allowance = (salary.special_allowance/12).round(2)
    gross = basic_salary + payslip.hra + payslip.payslip_allowances_total_value + payslip_special_allowance + payslip.arrears.to_f
    # method call for calculation pf,esic and total_deductions
    payslip_pf_value, payslip_esic_value,total_deducted_allowances_value = caluclate_pf_and_esic_value(payslip, salary_percentages, gross)
    total_deductions_value = payslip_pf_value.to_f + payslip_esic_value.to_f + total_deducted_allowances_value + payslip.pt.to_f + payslip.tds.to_f
    total_deductions_value +=  payslip.deductible_arrears.to_f
    net_pay = gross - total_deductions_value
    payslip.update(total_deductions: total_deductions_value, netpay: net_pay, gross_salary: gross, pf: payslip_pf_value, esic: payslip_esic_value, special_allowance: payslip_special_allowance, mode: mode)
    payslip
  end

  # author: sekhar
  # date: 18/11/2014
  # * This method is for calculate pf, esic and deductible allowances
  def caluclate_pf_and_esic_value(payslip, salary_percentages, gross)
    salary = payslip.employee.salary
    if salary.pf_apply == 'true'
      payslip_pf = payslip_pf_value(payslip.basic_salary, salary_percentages)
    else
      payslip_pf = nil
    end
    if salary.esic_apply == 'true'
      payslip_esic = payslip_esic_value(gross, salary_percentages)
    else
      payslip_esic = nil
    end
    total_deducted_allowances_value = deducted_allowances_total(payslip)
    return payslip_pf, payslip_esic, total_deducted_allowances_value
  end
end
