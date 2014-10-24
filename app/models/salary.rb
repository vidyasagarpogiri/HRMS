class Salary < ActiveRecord::Base
  has_one :employee
  has_many :insentives
  has_many :salary_increments


  has_many :allowances
  
  
  def payslip_allowances(payslip)
    non_deductable_allowances = allowances.where(is_deductable: false) 
    non_deductable_allowances.each do |allowance|
      total_value = payslip_allowance_value(payslip, allowance)
      Allowance.create(payslip_id: payslip.id, allowance_name: allowance.allowance_name, value: allowance.value, allowance_value: allowance.allowance_value, total_value: total_value )
    end
    
  end
  
  
  def payslip_allowance_value(payslip, allowance)

    if allowance.value.present?
      total_value = (payslip.basic_salary*allowance.value)/100
      return total_value
    else
    #TODO allowance_value depends on working days and actual working days
      total_value  = allowance.allowance_value/12
       return total_value
    end
  end
  
  
  
end
