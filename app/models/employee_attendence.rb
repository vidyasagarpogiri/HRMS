class EmployeeAttendence < ActiveRecord::Base
  has_many :employee_attendence_logs
  
  
  def self.selected_group_employees(group,id)
    if id.to_i == 0
      groups = group.constantize.all
      empoyee_ids = []
      groups.each do |group|        
        empoyee_ids << group.employees.where(status: false).pluck(:id)
      end
        empoyee_ids.flatten!
        empoyee_ids.uniq!
    else
      selected_group = group.constantize.find(id.to_i)
      empoyee_ids = selected_group.employees.where(status: false).pluck(:id)
    end
    empoyee_ids.sort
  end
  
  def self.repotee_employees(selected_group,manager)
    employee_ids = ReportingManager.where(manager_id: manager.id).map(&:employee_id)
    employee_ids.sort
  end
  
  def self.employees_of_required_group(group_type, id)
      if id.to_i == 0
        groups = group_type.constantize.all
        employees = []
        groups.each do |group|        
          employees << group.employees.where(status: false)
        end
          employees.flatten!
          employees.uniq!
      else
        selected_group = group_type.constantize.find(id.to_i)
        employees = selected_group.employees.where(status: false)
      end
      employees.sort_by(&:id)
  end
  
  def self.employees_of_reporting_manager(group_type, manager)
      employee_ids = ReportingManager.where(manager_id: manager.id).map(&:employee_id)
      employees = Employee.where(id: employee_ids)
      employees.sort_by(&:id)
  end
  
  
end
