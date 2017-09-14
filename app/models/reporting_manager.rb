class ReportingManager < ActiveRecord::Base
  
  belongs_to :employee
  belongs_to :department
  belongs_to :group
               
  def full_name               
     "#{self.employee.full_name}"
  end
  
end
         
