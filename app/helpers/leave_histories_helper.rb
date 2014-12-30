module LeaveHistoriesHelper

  def float_leave(leave_type_id)
	  #raise leave_type_id.inspect
	  case leave_type_id  
	  when 1 
	    'Quartely'
	  when 2
	    'Half Yearly'
	  else
	    'Annually'
	 end
	end
	
	def startenddate(date)
  #raise params.inspect
    applied_date = date.to_date
    #raise current_user.employee.group.leave_policy.floating_leave_period.inspect
	  case current_user.employee.group.leave_policy.floating_leave_period 
	  when 1 # quarterly
	   return applied_date.beginning_of_quarter, applied_date.end_of_quarter 
	  when 2 # half-yearly
	   year = applied_date.year
	   month = applied_date.month
	    if month <= 6
	      start_date = applied_date.beginning_of_year
	      end_date = "30/06/"+ year.to_s
	      return start_date, end_date
	    else
	      start_date = "01/07/"+ year.to_s
	      end_date = applied_date.end_of_year
	      return start_date, end_date
	    end
	   else
	     return applied_date.beginning_of_year, applied_date.end_of_year # annually
	   end
	end
	
	
	def check_float_leave_availability(date)
	  # raise date.to_date.beginning_of_quarter.inspect
	  #raise params.inspect
	  case 
	  
	  when 1
	  true if (date.to_date.beginning_of_quarter .. date.to_date.end_of_quarter).to_a.include?(date.to_date)
	 
	  when 2
	   #raise current_user.employee.group.leave_policy.floating_leave_period.inspect
	   leave_dates = LeaveHistory.where( employee_id = current_user.employee.id, leave_type_id = 2).map(&:from_date)
	      dates = []
	       leave_dates.each do |d|
	        dates << d.to_date
	        end
	        #raise leave_dates.inspect
	   leave_months =  dates.collect { |x| x.month}.present?
	   #raise leave_months.inspect
	  when 3
	   
	 end
	end
end
