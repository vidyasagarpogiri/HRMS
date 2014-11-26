class PayRollMaster < ActiveRecord::Base
  belongs_to :employee
end


#First Thing We have to send gross from payslip
#We have to find total_savings from Investment Declartion (Conditions : It did not crossed section wise max value.)
#We have to update every time TDS, education_cess and higher_education_cess
#Calculate TDS while EDIT PayRoll

