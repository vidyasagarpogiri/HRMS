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
  
  def weekends( end_date, start_date, department)
   #raise start_date.inspect
    weekends = [0, 6]
    remaining_days = (start_date .. end_date).to_a - select_holidays(department)
   holidays = (start_date .. end_date).to_a.length-(remaining_days).length
    result = remaining_days.select{ |k| weekends.include? (k.wday)}.count
   result = result + holidays
  end
  
  
  def select_holidays(department)
    a=[]
    department.events.each do |k|
    a << k.event_date.to_date
		#raise a.inspect
  end
  a
end


  def format_date(time)
    time = time.to_date if time
  	time.strftime("%d %b, %Y") if time
	end
	
	def format_date_without_year(time)
    time = time.to_date if time
  	time.strftime(" #{time.day.ordinalize} %b") if time
  	#{time.day.ordinalize}
	end
	
	
	 def format_date_time(time)
    time.strftime("%d %b, %Y  %I:%M %p") if time
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
    a= employee.leave_histories.where(status: LeaveHistory::APPROVED).sum("days")
    a.to_i
  end
  
 
 
 
  #leaves for current year according to leave policy
  
  
  
  
  def total_balance_leaves(employee)
  
  employee_join = employee.date_of_join.to_date
  
  if(employee_join.year == Date.current.cwyear)
  
   a =  ((13-employee_join.month)*employee.department.leave_policy.pl_this_year) - employee.leave_histories.where(status: LeaveHistory::APPROVED).sum("days") if employee.department.leave_policy.present?
   else
   
   a =  (12 * employee.department.leave_policy.pl_this_year) - employee.leave_histories.where(status: LeaveHistory::APPROVED).sum("days") if employee.department.leave_policy.present?
   end
    
  
   a 
   
  
  end


  
  def total_leaves(employee)
  employee_join = employee.date_of_join.to_date
  if(employee_join.year == Date.current.cwyear)
   a =  ((13-employee_join.month)*employee.department.leave_policy.pl_this_year) if employee.department.leave_policy.present?
   else
   
   a =  (12 * employee.department.leave_policy.pl_this_year)  if employee.department.leave_policy.present?
   end
    
  
   a 
   
  
  end
# caluculate carry forward leaves from previous year

def carry_forward_leaves(employee)
  
   employee_join = employee.date_of_join.to_date
 
  if(employee_join.year <= (Date.current.cwyear-1))
  
   c =  ((12-employee_join.month)*employee.department.leave_policy.pl_this_year) - employee.leave_histories.where(status: LeaveHistory::APPROVED).sum("days") if employee.department.leave_policy.present?
   
     if  c < employee.department.leave_policy.eligible_carry_forward_leaves && c <= 0
      return c
     elsif c >= employee.department.leave_policy.eligible_carry_forward_leaves
      return employee.department.leave_policy.eligible_carry_forward_leaves
     end
   else
   
   c =  (12 * employee.department.leave_policy.pl_this_year) - employee.leave_histories.where(status: LeaveHistory::APPROVED).sum("days") if employee.department.leave_policy.present?
    if  c < employee.department.leave_policy.eligible_carry_forward_leaves && c <= 0
      return c
     elsif c >= employee.department.leave_policy.eligible_carry_forward_leaves
      return 0
     end
   end
         
end



  def waiting_for_approval(employee)
    employee.leave_histories.where(status: LeaveHistory::HOLD).sum("days")
  end
  
  def employee_has_hold_leaves?
    if current_user.employee.leave_histories.where(:status => "HOLD").present?
      return true 
    else
      return false
    end
  end

		def allowance_value(value, salary)
			 (salary)*value/100

		end
  
  def reporting_manager_leaves?
    @reporting_manager = Employee.find(2).reporting_managers.first
		@department = @reporting_manager.department
	  @employees = @department.employees	
        a=0
    @employees.each do |employee|
  
      if employee.leave_histories.where(:status => "HOLD").present?
        a=1
      end
    end
    
    if a == 0
      return false
    else
      return true 
    end 
  end
  
  
 #-------------- sekhar - method for caluclate other allowance ----------------
  
  def allowance_total(allowances, salary)
      #raise allowances.inspect
      total = 0.0
      allowances.each do |allowance|
        if allowance.value.present?
        value = (salary.basic_salary * allowance.value)/100
        total += value
        else
        total += allowance.allowance_value
        end
      end
      salary_gross = salary.basic_salary + total + salary.pf + salary.esic
      remain_allowance = salary.gross_salary - salary_gross
  end
#--------- End of allowance caluclation method ------------------  


#-------------------- sekhar - code for Basic, pf, pf contribution, esic, esic contribution --------------------

# caluclation of basic salary of employee

 def basic(salary, percentages)
      gross = salary.gross_salary
      basic_value = 0
      percentages.each do |per|
        if per.name == "Basic"
          basic_value = (gross * per.value)/100
          break
        end
      end
      basic_value
  end
  
  
  def basic_value(salary, percentages)
      basic_value = 0
      percentages.each do |per|
        if per.name == "Basic"
          basic_value = (salary.to_f * per.value)/100
          break
        end
      end
      basic_value
  end
# end
  
# Caluclation of pf of employee  
  def pf(salary, percentages)
  #raise salary.inspect
      basic = salary.basic_salary
      pf_value = 0
      percentages.each do |per|
        if per.name == "PF"
          pf_value = (basic * per.value)/100
          break
        end
      end
      pf_value
  end
  
 # end
 
 # Caluclation of pf contribution of employee 
 
  def pf_contribution(salary, percentages)
      basic = salary.basic_salary
      pf_contribution_value = 0
      percentages.each do |per|
        if per.name == "Pf Contribution"
          pf_contribution_value = (basic * per.value)/100
          break
        end
      end
      pf_contribution_value
  end
# end
  
  def esic(salary, percentages)
      #raise salary.inspect
      gross = salary.gross_salary
      esic_value = 0
      percentages.each do |per|
        if per.name == "Esic"
          esic_value = (gross * per.value)/100
          break
        end
      end
      esic_value
  end
  
# end

# Caluclation of esic contribution of employee
  
  def esic_contribution(salary, percentages)
      gross = salary.gross_salary
      esic_contribution_value = 0
      percentages.each do |per|
        if per.name == "Esic Contribution"
          esic_contribution_value = (gross * per.value)/100
          break
        end
      end
      esic_contribution_value
  end

# end

#-------------- End of Code ------------------------------------------------------------------
  
#----------------- sekhar - code for allowances check ------------------------
  def value(allowance, emp_allowances)
   flag = present_allowance_value = present_allowance_percent = 0
   flag, present_allowance_value, present_allowance_percent = 1, emp_allowances.find_by_allowance_name(allowance).allowance_value, emp_allowances.find_by_allowance_name(allowance).value if emp_allowances.find_by_allowance_name(allowance).present?
   return flag, present_allowance_value, present_allowance_percent
  end
#----------------- end of code -------------------------------------
  
  
  
  def allowance_count_edit(salary)
      total = 0.0
      salary.allowances.each do |allowance|
        if allowance.value.present?
          value = (salary.basic_salary * allowance.value)/100
          total += value
        else
          total += allowance.allowance_value
        end
      end
      total
  end
  
  
  #--------------- code for monthly salary calculation ------------------
  def monthly(value)
    (value/12).round(2)
  end
  
  #----------------------------------------------------------------------
  
  

end
