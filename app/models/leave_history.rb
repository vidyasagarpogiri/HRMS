class LeaveHistory < ActiveRecord::Base
 	belongs_to :employee
	belongs_to :leave_type
	
	before_create :status_hold
	
	private
	def status_hold
	  self.status = "HOLD"
	end
end
