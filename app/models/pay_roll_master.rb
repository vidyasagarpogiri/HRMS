class PayRollMaster < ActiveRecord::Base
  belongs_to :employee
  
  
  #BalaRaju - Created Form 16 based on Employee and assesment_year 
  
  def self.form_16_create_or_update(employee, assesment_year, sum_of_declarations)
    pay_roll_master = employee.pay_roll_masters
    current_year_pay_roll_master = pay_roll_master.where(assesment_year: assesment_year) if pay_roll_master.present?
    if pay_roll_master.present? && current_year_pay_roll_master.present?
      @payroll = current_year_pay_roll_master.first.update(total_savings: sum_of_declarations)   
    else 
      @payroll = PayRollMaster.create(employee_id: employee.id, assesment_year: assesment_year, total_savings: sum_of_declarations )
    end
  end
  
end

#First Thing We have to send gross from payslip
#We have to find total_savings from Investment Declartion (Conditions : It did not crossed section wise max value.)
#We have to update every time TDS, education_cess and higher_education_cess
#Calculate TDS while EDIT PayRoll

