class EmployeeSkill < ActiveRecord::Base
  belongs_to :skill
  belongs_to :employee
end
