class EmployeesAppraisal < ActiveRecord::Base
  belongs_to :employee
  belongs_to :appraisal
end
