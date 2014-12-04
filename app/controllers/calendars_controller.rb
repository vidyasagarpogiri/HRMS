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
    @leaves = LeaveHistory.where(:employee_id => (@reportee_employees.pluck(:employee_id)), :status => "APPROVED")
    @employees = Employee.where(:employee_id => (@leaves.pluck(:employee_id)))
    #raise @leaves.inspect    
    respond_to do |format| 
      format.html # reporting_manager_calendar.html.erb     
      format.json do
        render :json =>  @leaves.map{|leave| {:title => leave.employee.full_name, :start => leave.from_date.to_date, :end => leave.to_date.to_date}}        
      end
    end      
  end
  
  def workgroup_calendar
    #@workgroup_id = Workgroup.find(params[:id].to_i)
    @group_employees = WorkgroupsEmployee.where(:workgroup_id => 1).pluck(:employee_id) #TODO pass @workgroup_id to :workgroup_id for dynamic values
    @group_holiday_calender = HolidayCalender.where(:group_id => @group_employees).map(&:event_id).uniq
    @group_events = Event.where(:id => @group_holiday_calender)
    respond_to do |format| 
      format.html # reporting_manager_calendar.html.erb 
      format.json do 
        render :json => @group_events.map { |event| {:title => event.event_name, :start => event.event_date.to_date} }
      end
    end    
    #raise @group_holiday_calender.inspect
  end
  
  def workgroup_leaves_calendar
     #@workgroup_id = Workgroup.find(params[:id].to_i)
     @group_employees = WorkgroupsEmployee.where(:workgroup_id => 1).pluck(:employee_id) #TODO pass @workgroup_id to :workgroup_id for dynamic values
     @group_leaves = LeaveHistory.where(:employee_id => @group_employees, :status => "APPROVED")
     respond_to do |format| 
      format.html # reporting_manager_calendar.html.erb 
      format.json do 
        render :json => @group_leaves.map { |event| {:title => leave.employee.full_name, :start => leave.from_date.to_date, :end => leave.to_date.to_date}}
      end
    end
  end
    
  def department_leaves_calendar    
    #@department = Department.find(params[:dept].to_i)    
    @department_employees = Employee.all.where(:department_id => 2).pluck(:id)    
    @department_leaves = LeaveHistory.where(:employee_id => @department_employees, :status => "APPROVED") 
    #raise @department_leaves.inspect
    respond_to do |format| 
      format.html # reporting_manager_calendar.html.erb     
      format.json do
        render :json =>  @department_leaves.map{|leave| {:title => leave.employee.full_name, :start => leave.from_date.to_date, :end => leave.to_date.to_date}}        
      end
    end          
  end         
 
  def department_calendar
    #@department = Department.find(params[:dept_id].to_i)   
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
        render :json => @all_leaves.map { |leave| {:title => leave.employee.full_name, :start => leave.from_date.to_date , :end => leave.to_date.to_date} }
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
