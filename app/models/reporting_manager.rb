class ReportingManager < ActiveRecord::Base
  belongs_to :employee
  belongs_to :department
  belongs_to :group
  
end
