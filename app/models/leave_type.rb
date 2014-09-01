class LeaveType < ActiveRecord::Base
  belongs_to :group
  belongs_to :leave_history
end
