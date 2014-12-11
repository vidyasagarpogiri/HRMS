class Salary < ActiveRecord::Base
  has_one :employee
  has_many :insentives
  has_many :salary_increments


  has_many :allowances
  
  def payslip_allowances(payslip)
    #all_allowances = allowances.all 
    allowances.each do |allowance|
      if allowance.is_deductable
        total_value = payslip_allowance_value(payslip, allowance)
        Allowance.create(payslip_id: payslip.id, allowance_name: allowance.allowance_name, value: allowance.value, allowance_value: allowance.allowance_value, total_value: total_value, is_deductable: true )
      else
        total_value = payslip_allowance_value(payslip, allowance)
        Allowance.create(payslip_id: payslip.id, allowance_name: allowance.allowance_name, value: allowance.value, allowance_value: allowance.allowance_value, total_value: total_value )
      end
    end
    
  end
  
  
  def payslip_allowance_value(payslip, allowance)
    if allowance.value.present?
      total_value = (payslip.basic_salary*allowance.value)/100
      return total_value
    else
    #TODO allowance_value depends on working days and actual working days
      total_value  = (allowance.allowance_value)
       return (total_value/12).round(2)
    end
  end
  
  
  
end
