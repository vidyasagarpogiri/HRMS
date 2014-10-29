class Notification < ActionMailer::Base
  require 'open-uri'
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
    #raise @leave_history.inspect
		 mail(:to => @employee.user.email, :subject => "Leave Approved")

	end
  
	def reject_leave(employee, leave_history)
	  @employee = employee
		@leave_history = leave_history

		 mail(:to => @leave_history.employee.user.email, :subject => "Leave Rejected")

	end
	
		def job_notification(user,recruitment)
		#raise params.inspect
	    @recruitment = recruitment
		  #raise @recruitment.inspect
      #users.each do |user|
		  mail(:to => user.email, :subject => "New Job Opening for #{@recruitment.title}.")
	  end
    
    def announcement_notification(user,announcement)
    @announcement = announcement
    mail(:to => user.email, :subject => "Announcement for #{@announcement.title}")
    end
    
    def event_notification(user,amzurevent)
    @amzurevent = amzurevent
    #raise @amzurevent.inspect
    mail(:to => user.email, :subject => "Amzur Technologies is conducting a #{@amzurevent.title} Event ")
    end
    
    def policy_notification(user,policy) 

    @policy = policy
    #attachments.inline['document'] = File.read("#{Rails.root}#{@policy.document}")
    mail(:to => user.email, :subject => "#{@policy.title} Policy ")
    end
    
    def holiday_list(user,events)
    @events = events
     mail(:to => user.email, :subject => "Holidays List")
    end
    
    def send_payslip
      mail(:to => "sekhar.beri@amzur.com", :subject => "payslip List") do format
        format.html { render "/payslips"}
        format.xlsx { attachments["/home/sekhar/payslip.xlsx"] }
      end
    end

end
    
