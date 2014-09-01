class LeaveHistoty < ActiveRecord::Base
  belongs_to :employee
  belongs_to :leave_types
end
