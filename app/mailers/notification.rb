class Notification < ActionMailer::Base
  default from: "from@example.com"
  
  def applyleave(employee, leave_history)
 
   @employee = employee
   @leave_history = leave_history
   #raise @employee.user.email.inspect
   #raise @leave_history.leave_type.type_name.inspect
   mail(:to => @employee.group.reporting_manager.employee.user.email, :subject => "#{@employee.first_name} Applied for leave #{@leave_history.leave_type.type_name} for #{@leave_history.days} day(s) ")
  end

	def accept_leave(employee, leave_history)
		@employee = employee
		@leave_history = leave_history
		 mail(:to => @employee.user.email, :subject => "#{@leave_history.leave_type.type_name} leave has been approved for #{@leave_history.days} day(s) ")
	end
  
	def reject_leave(employee, leave_history)
		@employee = employee
		@leave_history = leave_history
		 mail(:to => @employee.user.email, :subject => "#{@leave_history.leave_type.type_name} leave has been rejected for #{@leave_history.days} day(s) ")
	end
end


