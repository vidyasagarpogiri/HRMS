require 'rubygems'
require 'rufus-scheduler'
require 'active_record'

#scheduler = Rufus::Scheduler.new
#singleton @pattabhi
scheduler = Rufus::Scheduler.singleton

# eg:Thursday, November 6, 2014 11:58 PM (every moth - crom job)
scheduler.cron '18 16 5 *  *'  do 
   puts "hello"
   
    @month = DateTime.now.month-1
	  @year = DateTime.now.year
	  if @month == 0
	    @month = 12
	    @year = @year - 1 
	  end
	  @payslips = Payslip.where(:month => @month ,:year => @year)
	  @payslips.each do |payslip| 
	    file_path = "#{Rails.root}/public/PAYSLIPS/#{payslip.year}/#{payslip.month}"
      unless File.exist?(file_path)
        FileUtils.mkdir_p file_path 
      end 
      pdf = ReportPdf.new(payslip)
     pdf.render_file File.join(file_path, "#{payslip.employee.id}.pdf")
      Notification.delay.send_pdf(payslip, File.join(file_path, "#{payslip.employee.id}.pdf"))
	  end
	  
 # @employees = Employee.all
  #@employees.where(status: false).each do |emp|
      #Notification.event_notification(emp.user, AmzurEvent.last).deliver
      #Notification.send_pdf(emp.user,emp).deliver
 
end



=begin
scheduler.cron '0 0 7 * *'  do 
   #puts "hello"
end

#cron job to do a task in every month day 7 at zero th hour  5th minute (5 min after mid night) 
scheduler.cron '5 0 7 * *'  do 
   #puts "hello"
end
=end





#code for birth day notification

  scheduler.cron '5 0 * *	*	' do    # This scheduler will run at midnight 12:05 everyday (birthday email) 
  puts "happy bday"
  @employees = Employee.all
  @employees.each do |employee|
    if(Date.today.month == employee.date_of_birth.to_date.month)
      if(Date.today.mday == employee.date_of_birth.to_date.mday)
       #raise emp.full_name.inspect
        Employee.where(status: false).each do |emp|
        Notification.birthday_notification(emp.user,employee).deliver
        end
      end
    end                        
 end
end



 
