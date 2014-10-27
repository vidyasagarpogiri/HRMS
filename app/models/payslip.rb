class Payslip < ActiveRecord::Base
  belongs_to :employee
  has_many :allowances
  
  #TODO remove Payslip allowance table
  
  def payslip_allowances_total_value
    total_allowance_value = 0 
    allowances.each do |allowance|
      total_allowance_value += allowance.total_value
    end
    total_allowance_value
  end
  
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
  
end
