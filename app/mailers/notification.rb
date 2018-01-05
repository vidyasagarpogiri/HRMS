class Notification < ActionMailer::Base
  default from: "from@example.com"
  
  def applyleave(employee, leave_history)
                                            
   @employee = employee                                
   @leave_history = leave_history                      
   #raise @employee.reporting_manager.inspect
   mail(:to => @employee.reporting_manager_user, :subject => "Leave Applied By "  " #{@employee.first_name} #{@employee.last_name}")
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
		 mail(:to => @leave_history.employee.user.email, :subject => "Leave Rejected")

	end
end


              
