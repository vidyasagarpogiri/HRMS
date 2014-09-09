class Notification < ActionMailer::Base
  default from: "from@example.com"
  
  def applyleave(employee, leave_history)
 
   @employee = employee
   @leave_history = leave_history
   #raise @employee.user.email.inspect
   #raise @leave_history.leave_type.type_name.inspect
   mail(:to => @employee.user.email, :subject => "#{@employee.first_name} Applied for leave #{@leave_history.leave_type.type_name} for #{@leave_history.days} day(s) ")
  end
  
end


