class LeaveHistory < ActiveRecord::Base
 	belongs_to :employee
	belongs_to :leave_type
	
	before_create :status_hold
	
	HOLD = "HOLD"
	ACCEPTED = "ACCEPTED"
	REJECTED = "REJECTED"
	
	
	private
	def status_hold
	  self.status = HOLD
	end
end
