class EmployeesAppraisalList < ActiveRecord::Base
  belongs_to :appraisal_cycle
  belongs_to :employee
  belongs_to :appraisal
end
