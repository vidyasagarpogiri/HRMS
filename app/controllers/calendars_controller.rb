# Author: Priyanka
# Calendar view for Leaves and Holidays
class CalendarsController < ApplicationController

  def reporting_manager_calendar 
    @reportee_employees = current_user.employee.reportees_employees
    @reportee_employees_groups = current_user.employee.reportees_employees.pluck(:group_id).uniq    
    @events = HolidayCalender.where(:group_id => @reportee_employees_groups).pluck(:event_id).uniq
    @event_records = Event.where(:id => @events)#.pluck(:event_name, :event_date)
    #raise @event_records.inspect  
    respond_to do |format| 
      format.html # reporting_manager_calendar.html.erb 
     format.json do 
      render :json => @event_records.map { |event| {:title => event.event_name, :start => event.event_date.to_date} }
    end
    end     
  end
  
  def reportees_leaves_calendar
    @reportee_employees = current_user.employee.reportees_employees
    #raise @reportee_employees.pluck(:employee_id).inspect    
    #@reportee_name = @reportee_employees.pluck(:first_name)
    @leaves = LeaveHistory.where(:employee_id => (@reportee_employees.pluck(:employee_id)), :status => "APPROVED")
    @name = Employee.where(:employee_id => (@leaves.pluck(:employee_id)))
    @record = @leaves + @name #if (@leaves.pluck(:employee_id)).to_i == @name.pluck(:employee_id).to_i    
    #raise @name.pluck(:employee_id).to_i.inspect       
  end
  
  def workgroup_calendar
    #@department_leaves = LeaveHistory.where(:department_id => 2)
    #raise @department_leaves.inspect
  end
    
  def department_leaves_calendar    
    #@department = Department.find(params[:dept].to_i) 
    #raise @department.inspect
    #@all_departments = Department.all
    @department_employees = Employee.all.where(:department_id => 2)
    #@id = @department_employees.id
    #@id = @department_employees.employee_id
    #@department_leaves = @all_leaves.all.where(:employee_id => "@department_employees.employee_id".to_i)   
    @employees = Employee.all    
  end         
 
  def department_calendar
    #@department = Department.find(params[:dept_id].to_i)
    #raise @department.inspect
    
    @group_employees = Employee.where(:department_id => :department_id).pluck(:group_id).uniq
    @group_holiday_calender = HolidayCalender.where(:group_id => @group_employees).pluck(:event_id).uniq    
    @department_events = Event.where(:id => @group_holiday_calender)
    #raise @department_events.inspect
     respond_to do |format| 
      format.html # reporting_manager_calendar.html.erb 
      format.json do 
        render :json => @department_events.map { |event| {:title => event.event_name, :start => event.event_date.to_date} }
      end
    end
  end
  
  def company_leaves_calendar
    @all_leaves = LeaveHistory.all.where(:status => "APPROVED")
     respond_to do |format| 
      format.html # reporting_manager_calendar.html.erb 
      format.json do 
        #render :json => @all_leaves.map { |event| {:title => event.event_name, :start => event.event_date.to_date} }
      end
    end       
  end
  
  def company_calendar   
    @all_holidays = Event.all
    #raise @all_holidays.inspect
    respond_to do |format| 
      format.html # reporting_manager_calendar.html.erb 
      format.json do 
        render :json => @all_holidays.map { |event| {:title => event.event_name, :start => event.event_date.to_date} }
      end
    end       
  end
  
end
