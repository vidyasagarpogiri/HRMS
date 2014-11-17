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
		  mail(:to => user.email, :subject => "Bring Your Buddy - Employee Referral - New Job Opening for #{@recruitment.title}.")
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
    
    def send_payslip(mail,month_name,year)
       attachments.inline["payroll.xlsx"] = File.read("#{Rails.root}/public/Payroll/#{month_name}-#{year}-payslips.xlsx")
       #attachments.inline["payslip.xlsx"] = File.read("#{Rails.root}/public/#{month_name}-#{year}-payslips.xlsx")
       mail(:to => mail, :subject => "Payroll for #{month_name}-#{year}")
    end

 
#birth day alert code
   def birthday_notification(user,employee)  
       @user = user
       @employee = employee                                          
       attachments.inline["birthday.jpg"] = File.read("#{Rails.root}/public/assets/birthdaycards/#{rand(6)}.jpg")
       mail(:to => @user.email, :subject => "Happy Birthday To #{@employee.full_name}  ")
   end


   def send_pdf(payslip, file_path)
    @employee = payslip.employee
    @user = @employee.user
    attachments.inline["payslip.pdf"] = File.read(file_path)
    mail(:to => @user.email, :subject => "payslip of #{I18n.t("date.abbr_month_names")[Date.today.month-1]} of Mr. #{@employee.full_name}  ")
   end
    
   def reference_notification(current_user) # email for reference letter
   #raise pdf.inspect
   #@employee = Employee.user @user.employee
   @employee = current_user
   @user = current_user
   #raise @user.employee.inspect
   #raise attachments.inspect
   #attachments.inline["ReferenceLetter.pdf"] = File.read("/home/downloads/")
   #raise user.email.inspect
   #mail(:to => user.email, :subject => "reference Letter")
   referenceletter = ReferenceLetter.new(@user)
   attachments["ReferenceLetter.pdf"] = { :mime_type => 'application/pdf', :content => referenceletter.render }
  mail(:to => @user.email, :subject => "Amzur Technologies - Reference Letter")
   end 
    
   def address_notification(current_user) # email for address proof
   @employee = current_user
   @user = current_user
   addressproofletter = AddressProofLetter.new(@user)
   attachments["AddressProofLetter.pdf"] = { :mime_type => 'application/pdf', :content => addressproofletter.render }
  mail(:to => @user.email, :subject => "Amzur Technologies - Address Proof")
   end 

   def salary_notification(current_user) # email for salary certificate
   @employee = current_user
   @user = current_user
   salarycertificate = SalaryCertificate.new(@user)
   attachments["SalaryCertificate.pdf"] = { :mime_type => 'application/pdf', :content => salarycertificate.render }
  mail(:to => @user.email, :subject => "Amzur Technologies - Salary Certificate")
   end  
    
end
    
