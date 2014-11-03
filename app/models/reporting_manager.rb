class ReportingManager < ActiveRecord::Base
  has_many :employees
  belongs_to :department
  belongs_to :group
  
  def full_name
     "#{self.employee.full_name}"
  end
  
end
