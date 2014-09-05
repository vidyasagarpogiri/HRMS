class LeaveHistory < ActiveRecord::Base
 	belongs_to :employee
	belongs_to :leave_type
end
