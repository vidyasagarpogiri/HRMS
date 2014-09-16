class Notification < ActionMailer::Base
  default from: "from@example.com"
  
  def applyleave(employee, leave_history)
 
   @employee = employee
   @leave_history = leave_history
   #raise @employee.user.email.inspect
   #raise @leave_history.leave_type.type_name.inspect
   mail(:to => @employee.reporting_manager.user.email, :subject => "#{@leave_history.subject}")
  end

	def accept_leave(employee, leave_history)
	#	@employee.user.email
		@employee = employee
		@leave_history = leave_history

		 mail(:to => @employee.user.email, :subject => "Leave Approved")

	end
  
	def reject_leave(employee, leave_history)
		@employee = employee
		@leave_history = leave_history

		 mail(:to => @employee.user.email, :subject => "Leave Rejected")

	end
end


