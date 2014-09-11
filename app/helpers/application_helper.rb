module ApplicationHelper


 def format_exp_date(time)
  date = time.to_date if time
   date.strftime("%b, %Y") if time 
  end
  
  
  def difference_in_months(date1, date2)
    date1 = date1.to_date if date1.present? 
    date2 = date2.to_date if date2.present?
    number_of_months = (date2.year * 12 + date2.month) - (date1.year * 12 + date1.month)
    months = number_of_months.to_i
    "#{pluralize(months/12, 'year')} #{pluralize(months%12, 'month')}"
    
  end
  
  def weekends( end_date, start_date)
   #raise start_date.inspect
    weekends = [0, 6]
    remaining_days = (start_date .. end_date).to_a - select_holidays
   holidays = (start_date .. end_date).to_a.length-(remaining_days).length
    result = remaining_days.select{ |k| weekends.include? (k.wday)}.count
   result = result + holidays
  end
  
  
  def select_holidays
    a=[]
    Event.all.each do |k|
    a << k.event_date.to_date
		#raise a.inspect
  end
  a
end

  def leavesDateWise(search_date)
  leaves_array=[]
    LeaveHistory.all.each do |leave|
      (leave.from_date.to_date..leave.to_date.to_date).to_a.each do |date|
        if date == search_date
          leaves_array << leave
        end
      end
    end
    leaves_array
  end
 
 
  def remaining_leaves(employee, leave_type)
     employee.leave_histories.where(leave_type_id: leave_type).sum("days")
  end
  
  def total_used_leaves(employee)
    employee.leave_histories.where(status: LeaveHistory::APPROVED).sum("days")
  end
  
  def total_balance_leaves(employee)
    (employee.group.leave_policy.pl_this_year + employee.group.leave_policy.pl_this_year)- employee.leave_histories.where(status: LeaveHistory::APPROVED).sum("days")  if employee.group.leave_policy.present?
  end

  def waiting_for_approval(employee)
    employee.leave_histories.where(status: LeaveHistory::HOLD).sum("days")
  end
end
