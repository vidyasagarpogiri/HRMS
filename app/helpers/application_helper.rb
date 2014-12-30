module ApplicationHelper

# will take datetime as input and will return date in given format
 def format_exp_date(time)
  date = time.to_date if time
   date.strftime("%b, %Y") if time 
 end
  
  #def float_leave
	  # leave_history"=>{"leave_type_id"=>"2", "reason"=>"hello", "is_halfday"=>"full_day", "from_date"=>"26/12/2014", "to_date"=>"26/12/2014", "section"=>"Morning"}, "leave_date"=>"", "float_leave_date"=>"26/12/2014"
	#  raise @employee.group.leave_policy.inspect
	#  case floating_leave_period
	#  when 1 
	#    'Quartely'
	#  when 2
	#    'Half Yearly'
	#  else
	#    'Annually'
	# end
#	end
  
  
#will calcualte months difference between two dates 
 def difference_in_months(date1, date2)
    date1 = date1.to_date if date1.present? 
    date2 = date2.to_date if date2.present?
    number_of_months = (date2.year * 12 + date2.month) - (date1.year * 12 + date1.month)
    months = number_of_months.to_i
    "#{pluralize(months/12, 'year')} #{pluralize(months%12, 'month')}"   
 end
 
 # will take start and end dates,group and return number of days between two dates by excluding holidays of that group and weekends  
 def weekends( end_date, start_date, group)
    weekends = [0, 6]
    remaining_days = (start_date .. end_date).to_a - select_holidays(group)
    holidays = (start_date .. end_date).to_a.length-(remaining_days).length
    result = remaining_days.select{ |k| weekends.include? (k.wday)}.count
    result = result + holidays
 end
 # this method will return holidys list of a particular group which was passed as a parameter   
 def select_holidays(gro)
    holidays_array=[]
    gro.events.each do |k|
    holidays_array << k.event_date.to_date
		end
    holidays_array
  end

# this method will return date in required format
  def format_date(time)
    time = time.to_date if time
  	time.strftime("%d %b, %Y") if time
	end
#for mate time wih am and pm
  def format_time(time)
    time.strftime("%H:%M %P") if time
  end
	
	
	
# this method is for to get date with out year	
	def format_date_without_year(time)
    time = time.to_date if time
  	time.strftime(" #{time.day.ordinalize} %b") if time
	end
	
	# this method retun time or date format by taking a time stamp as parameter
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
 
 # returns remaining leaves of employee deducting after approval form employee leaves
  def remaining_leaves(employee, leave_type)
     employee.leave_histories.where(leave_type_id: leave_type).sum("days")
  end
 # returs total leaves used by employee  
  def total_used_leaves(employee)
    a= employee.leave_histories.where(status: LeaveHistory::APPROVED).sum("days")
    a.to_f
  end
  
  #leaves for current year according to leave policy @pattabhi
  
  def total_balance_leaves(employee)  
   employee_join = employee.date_of_join.to_date
   if(employee_join.year == Date.current.cwyear)
    a =  ((13-employee_join.month)*employee.group.leave_policy.pl_this_year) - employee.leave_histories.where(status: LeaveHistory::APPROVED).sum("days") if employee.group.leave_policy.present?
   else
    a =  (12 * employee.group.leave_policy.pl_this_year) - employee.leave_histories.where(status: LeaveHistory::APPROVED).sum("days") if employee.group.leave_policy.present?
   end
   a 
  end
  
 # leaves are caliculated based on the joining day @pattabhi
  def total_leaves(employee)
    employee_join = employee.date_of_join.to_date
    if(employee_join.year == Date.current.cwyear)
      a =  ((13-employee_join.month)*employee.group.leave_policy.pl_this_year) if employee.group.leave_policy.present?
    else
      a =  (12 * employee.group.leave_policy.pl_this_year)  if employee.group.leave_policy.present?
   end  
   a 
  end
  
  
# caluculate carry forward leaves from previous year @pattabhi

  def carry_forward_leaves(employee)
   employee_join = employee.date_of_join.to_date
   if(employee_join.year <= (Date.current.cwyear-1))
    c =  ((12-employee_join.month)*employee.group.leave_policy.pl_this_year) - employee.leave_histories.where(status: LeaveHistory::APPROVED).sum("days") if employee.group.leave_policy.present?
   if  c < employee.group.leave_policy.eligible_carry_forward_leaves && c <= 0
    return c
   elsif c >= employee.group.leave_policy.eligible_carry_forward_leaves
    return employee.group.leave_policy.eligible_carry_forward_leaves
   end
   else   
      c =  (12 * employee.group.leave_policy.pl_this_year) - employee.leave_histories.where(status: LeaveHistory::APPROVED).sum("days") if employee.group.leave_policy.present?
      if  c < employee.group.leave_policy.eligible_carry_forward_leaves && c <= 0
        return c
      elsif c >= employee.group.leave_policy.eligible_carry_forward_leaves
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
	  (salary*value)/100
	end
  
  def reporting_manager_leaves?
    @reporting_manager = Employee.find(2).reporting_managers.first
		@group = @reporting_manager.group
	  @employees = @group.employees	
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
    total_added_allowances = total_deductable_allowances = total_allowance = 0.0
    allowances.each do |allowance|
     unless allowance.is_deductable
       if allowance.value.present?
          value = (salary.basic_salary * allowance.value)/100
          total_added_allowances += value
       else
          total_added_allowances += allowance.allowance_value
       end
     else
       if allowance.value.present?
          value = (salary.basic_salary * allowance.value)/100
          total_deductable_allowances += value
       else
          total_deductable_allowances += allowance.allowance_value
       end
     end
    end
    total_allowance = total_added_allowances - total_deductable_allowances
    salary_gross = salary.basic_salary + total_allowance + salary.pf + salary.esic
    remain_allowance = salary.gross_salary - salary_gross
  end
  
  def allowance_total_by_salary(salary)  #1
    allowances = salary.allowances
    allowances.where(is_deductable: false).sum(:total_value)
  end
#--------- End of allowance caluclation method ------------------  


#-------------------- sekhar - code for Basic, pf, pf contribution, esic, esic contribution --------------------

# caluclation of basic salary of employee

 def calculate_basic(salary, percentages) #2
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
      basic_value.round(2)
  end
# end
  
# Caluclation of pf of employee  
  def calculate_pf(salary, percentages)
      basic = salary.basic_salary
      pf_value = 0
      percentages.each do |per|
        if per.name == "PF"
          pf_value = (basic * per.value)/100
          break
        end
      end
      pf_value.round(2)
  end
  
 # end
 
 # Caluclation of pf contribution of employee 
 
=begin  def pf_contribution(salary, percentages)
      basic = salary.basic_salary
      pf_contribution_value = 0
      percentages.each do |per|
        if per.name == "PF Contribution"
          pf_contribution_value = (basic * per.value)/100
          break
        end
      end
      pf_contribution_value
  end
=end
  
  def calculate_esic(salary, percentages)
      #raise salary.inspect
      gross = salary.gross_salary
      esic_value = 0
      percentages.each do |per|
        if per.name == "Esic"
          esic_value = (gross * per.value)/100
          break
        end
      end
      esic_value.round(2)
  end
  
# end

# Caluclation of esic contribution of employee
  
=begin  def esic_contribution(salary, percentages)
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

=end

#will calculate HRA based on basic 
def calculate_hra(salary, percentages)
   hra_value = 0
   percentages.each do |per|
    if per.name == "HRA"
     hra_value = (salary * per.value)/100
     break
    end
   end
   hra_value
end

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
  
  
  #--------------- code for monthly salary calculation - sekhar ------------------
  def monthly(value)
    (value/12).round(2)
  end
  
  #----------------------------------------------------------------------
  
=begin
    code for payslips calculation -sekhar
    this will return netpay of each employee by calculating it indivisually
=end
def calculate_net_salary(salary)
   total_deductions = 0.0
   netpay = 0.0
   allowances = salary.allowances
   allowances.each do |allowance|
      if allowance.is_deductable
        total_deductions += allowance.allowance_value
      end
   end
   total_deductions = total_deductions + salary.pf + salary.esic
   netpay = salary.gross_salary - total_deductions
   return netpay.round(2) , total_deductions.round(2) 
end

def update_net_salary(payslip)
  raise payslip.inspect
  total_deductions = payslip.total_deductions + payslip.pt.to_f + payslip.tds.to_f 
  basic_salary = payslip.basic_salary
  payslip_gross_salary = payslip.gross_salary
  payslip_allowances = @payslip.payslips_allowances
  raise payslip_allowances.inspect
  payslip_allowances.each do |all|
    payslip_allowance = Allowance.where(:id => all.allowance_id, :salary_id => @payslip.employee.salary.id).first
    if all.is_deductable
      
    end
  end
end

#---------------------------------------------------------------
# monthly calculations of payslips

  def payslip_basic(salary, employee_working_days, actual_days)
    payslip_basic = (salary*employee_working_days)/(actual_days) 
  end 
  
  def payslip_pf_value(basic_salary, salary_percentages)
     payslip_pf_value = 0
       salary_percentages.each do |per|
        if per.name == "PF"
          payslip_pf_value = (basic_salary * per.value)/100
          break
        end
      end
      payslip_pf_value.round(2)
  end
  
  def payslip_esic_value(gross_salary, salary_percentages)
     esic_value = 0
       salary_percentages.each do |per|
        if per.name == "Esic"
          esic_value = (gross_salary * per.value)/100
          break
        end
      end
      esic_value.round(2)
  end
  
  def payslip_special_allowances(spcl_allowance, working_days, actual_days)
     (spcl_allowance*working_days)/(actual_days) 
  end
  

  
  def deducted_allowances_total(payslip)
    allowance_deducted_total = 0.0
    allowances = payslip.allowances.where(:is_deductable => true)
    allowances.each do |allowance|
        allowance_deducted_total += allowance.total_value
    end
    allowance_deducted_total
  end
  
  def value_deductable(allowance, emp_allowances)
    if emp_allowances.find_by_allowance_name(allowance).present?
     if  emp_allowances.find_by_allowance_name(allowance).is_deductable
      return true
     end
   end
  end
  
  # for calculating sum pf allowances
  
  def fbp_allowance(allowances, basic)
    fbp_total = 0.0
    allowances.each do |allowance|
    if allowance.value.present?
      fbp_total += (basic*allowance.value)/100
    else
      fbp_total += allowance.allowance_value
    end  
  end
    return fbp_total
  end
  
  # method for calculating netpay total from all employee payslips -sekhar
  def total_netpay(payslips)
    payslips.sum(:netpay).round(2)
  end

end
