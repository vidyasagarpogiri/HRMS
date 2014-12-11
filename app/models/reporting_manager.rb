class ReportingManager < ActiveRecord::Base
  belongs_to :employee
  belongs_to :department
  belongs_to :group
  
  def full_name
     "#{self.employee.full_name}"
  end
  
  
  def self.reporting_data
    a = []
    Employee.all.each do |emp|
      a << {id: emp.id, employees: report_emp(emp.id) }
    end
    a
  end
  
  def manager
    Employee.find(manager_id)
  end
  
  def manager_employees
    employees = ReportingManager.where(manager_id: manager_id).map(&:employee)
  end 
  
  def reportee_employees
    employees = ReportingManager.where(manager_id: employee_id).map(&:employee).map(&:id)
  end
  
  def self.report_emp(emp)
    employees = ReportingManager.where(manager_id: emp).map(&:employee).map(&:id)
  end
  
end
