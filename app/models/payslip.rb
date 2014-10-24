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
  
end
