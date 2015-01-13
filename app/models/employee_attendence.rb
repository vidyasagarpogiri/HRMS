class EmployeeAttendence < ActiveRecord::Base
  has_many :employee_attendence_logs
end
