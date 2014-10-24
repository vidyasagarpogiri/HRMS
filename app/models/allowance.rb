class Allowance < ActiveRecord::Base
  belongs_to :salary
  belongs_to :payslip
  
 # validates :value, presence: true, numericality: true 	
  
end


