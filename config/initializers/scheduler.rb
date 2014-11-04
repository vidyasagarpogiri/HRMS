require 'rubygems'
require 'rufus-scheduler'
require 'active_record'

#scheduler = Rufus::Scheduler.new
#singleton @pattabhi
scheduler = Rufus::Scheduler.singleton

=begin
scheduler.cron '0 0 7 * *'  do 
   #puts "hello"
end

#cron job to do a task in every month day 7 at zero th hour  5th minute (5 min after mid night) 
scheduler.cron '5 0 7 * *'  do 
   #puts "hello"
end

# schedular to do job in every 24 hrs
scheduler.every '24h' do
  # do something every 24 hours
end

scheduler.every '10s' do
  puts " hello "
end
=end

 scheduler.cron '5 0 * *	*	' do    # This scheduler will run at midnight 12:05 everyday for birthday mail  
   	
  #scheduler.every '24h' do   
  #puts "happy bday" 
    
	  
  @employees = Employee.all
  @employees.each do |employee|
    if(Date.today.month == employee.date_of_birth.to_date.month)
       if(Date.today.mday == employee.date_of_birth.to_date.mday)
        #raise employee.full_name.inspect
         Employee.where(status: false).each do |emp|
         #raise emp.inspect
         Notification.birthday_notification(emp.user,employee).deliver
         end
       end
     end                        
  end
end
