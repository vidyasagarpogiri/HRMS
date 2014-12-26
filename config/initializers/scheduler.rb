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
  #puts "happy bday"
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
# to change ff_status of employee according to date of exit 
 scheduler.cron '0 0 * * *' do
    exit_date = Date.today.strftime("%d/%m/%Y").to_s
    @stauses = FfStatus.where(:date_of_exit == exit_date)
    @stauses.each do |status|
      status.employees.each do |employee|
        employee.update(:status => true)
      end 
    end
 end
  
  
  # to change employee available leaves every month accumlate according to leave policy
  #TODO Month Starting Corn Job
  scheduler.cron '30 5 1 * *' do
    Employee.all.each do |employee| 
      leave = employee.leave || employee.create_leave(pl_carry_forward_prev_year: 0, available_leaves: 0)
	    a_leaves = leave.available_leaves ||  0
	    cf_leaves = leave.pl_carry_forward_prev_year || 0
	    
	    group = employee.group
      if group.present? && group.leave_policy.present?
        leave_policy = group.leave_policy
        a_leaves += leave_policy.pl_this_year
        leave.update(available_leaves: a_leaves)
      end
	  end
  end

#to change 

scheduler.cron '0 4 1 1 *' do 

   Employee.all.each do |employee|
    leave = employee.leave 
	  if leave.present?
	    cf_leaves = leave.pl_carry_forward_prev_year || 0
	    a_leaves = leave.available_leaves || 0
	    group = employee.group
	    leave_policy = group.leave_policy if group.present?
      if group.present? && leave_policy.present?
        #a_leaves += leave_policy.pl_this_year
        leave_policy_cf_leaves = leave_policy.eligible_carry_forward_leaves || 0
        max_carry_forward_leaves = leave_policy.max_carry_forward_leaves || 0
        if leave_policy_cf_leaves >= a_leaves
          carry_leaves = a_leaves
        else
          carry_leaves = [ cf_leaves +  leave_policy_cf_leaves, a_leaves].min
        end
        final_cf_leaves = [max_carry_forward_leaves,  carry_leaves].min
        leave.update(available_leaves: final_cf_leaves, pl_carry_forward_prev_year: final_cf_leaves )
      else
        0
      end
	  else
	    0
	  end #Leave.present?
	 end 
end
 
