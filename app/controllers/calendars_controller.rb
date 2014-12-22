# Author: Priyanka
# Calendar view for Leaves and Holidays
class CalendarsController < ApplicationController

  def index
  #calendar_type=Group&department_id=&group_id=&workgroup_id
    @calendar_events = '/calendar.json'
    if params[:calendar_type].present? && params[:calendar_type] != "Company" 
      calendar_type = params[:calendar_type]
      if calendar_type == "Department"
        @employees = if params[:department_id].present? 
          @id = params[:department_id]
          @department = Department.find(params[:department_id]) 
          @calendar_events = "/calendar.json?calendar_type=Department&department_id= #{params[:department_id]}"
          @department.employees
        else
          @calendar_events = '/calendar.json?calendar_type=Department'
          Employee.all
        end    
      @group_employees = @employees.pluck(:group_id).uniq     
      @group_holiday_calender = HolidayCalender.where(:group_id => @group_employees).pluck(:event_id).uniq    
      @all_holidays = Event.where(:id => @group_holiday_calender)
      @all_leaves = LeaveHistory.where(:employee_id => @employees, :status => "APPROVED")
      #--------------------------------------------------------------------------------------------------
       
      elsif calendar_type == "Group"
        @employees = if params[:group_id].present? 
          @group = Group.find(params[:group_id])
          @calendar_events = "/calendar.json?calendar_type=Group&group_id= #{params[:group_id]}"
          @all_holidays = @group.events
          @group.employees 
        else
          @calendar_events = "/calendar.json?calendar_type=Group"
          Employee.all.map(&:employee_id).uniq
        end 
        @group_holiday_calender = HolidayCalender.where(:group_id => @employees).map(&:event_id).uniq
        @all_holidays = Event.where(:id => @group_holiday_calender)   
        @all_leaves = LeaveHistory.where(:employee_id => @employees, :status => "APPROVED") 
       
       #------------------------------------------------------------------------------------------------
      elsif calendar_type == "Workgroup"
        @employees = if params[:workgroup_id].present? 
            @workgroup = Workgroup.find(params[:workgroup_id])
            @calendar_events = "/calendar.json?calendar_type=Workgroup&workgroup_id= #{params[:workgroup_id]}"
            WorkgroupsEmployee.where(:workgroup_id => params[:workgroup] ).map(&:employee_id).uniq << Employee.find(@workgroup.admin_id)
            
          else
            @calendar_events = "/calendar.json?calendar_type=Workgroup"
            Employee.all.map(&:employee_id).uniq
          end 
       @group_holiday_calender = HolidayCalender.where(:group_id => @employees).map(&:event_id).uniq
       @all_holidays = Event.where(:id => @group_holiday_calender)   
       @all_leaves = LeaveHistory.where(:employee_id => @employees, :status => "APPROVED") 
       #raise @all_holidays.inspect 
      end
      #---------------------------------------------------------------------------------------------------
    else
       @all_holidays = Event.all
       @all_leaves = LeaveHistory.all.where(:status => "APPROVED")
    end
    response1 = @all_holidays.map { |event| {:title => event.event_name, :start => event.event_date.to_date}  }
    response2 =  @all_leaves.map { |leave| {:title => leave.employee.full_name, :start => leave.from_date.to_date , :end => leave.to_date.to_date.tomorrow} } 
    response = response1 + response2 
    @response = response.to_json
    respond_to do |format| 
      format.html
      format.js
      format.json do 
        render :json => response
      end
    end       
  end

=begin
  def reporting_manager_calendar   
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
    #raise @leaves.inspect    
    respond_to do |format| 
      format.html # reporting_manager_calendar.html.erb     
      format.json do
        render :json =>  @leaves.map{|leave| {:title => leave.employee.full_name, :start => leave.from_date.to_date, :end => leave.to_date.to_date.tomorrow}}        
      end
    end      
  end
  
  def workgroup_calendar   
    @employees = if params[:workgroup].present? 
      @workgroup = Workgroup.find(params[:workgroup])
      WorkgroupsEmployee.where(:workgroup_id => params[:workgroup] ).map(&:employee_id).uniq
    else
      Employee.all.map(&:employee_id).uniq
    end         
    #@group_employees = WorkgroupsEmployee.where(:workgroup_id => 3).pluck(:employee_id)#TODO pass @workgroup_id to :workgroup_id for dynamic values    
    @group_holiday_calender = HolidayCalender.where(:group_id => @employees).map(&:event_id).uniq
    @group_events = Event.where(:id => @group_holiday_calender)
    respond_to do |format| 
      format.html # reporting_manager_calendar.html.erb
      format.js
      format.json do 
        render :json => @group_events.map { |event| {:title => event.event_name, :start => event.event_date.to_date} }
      end
    end        
  end
  
  def workgroup_leaves_calendar
    @employees = if params[:workgroup].present? 
      @workgroup = Workgroup.find(params[:workgroup])
      WorkgroupsEmployee.where(:workgroup_id => params[:workgroup] ).map(&:employee_id).uniq #<< Employee.where(:id => @workgroup.admin_id)
    else
      Employee.all.map(&:employee_id).uniq
    end     
    #raise @employees.inspect 
    @group_leaves = LeaveHistory.where(:employee_id => @employees, :status => "APPROVED") 
    #raise @group_leaves.inspect    
    respond_to do |format| 
      format.html 
      format.js
      format.json do 
        render :json => @group_leaves.map { |leave| {:title => leave.employee.full_name, :start => leave.from_date.to_date, :end => leave.to_date.to_date.tomorrow}}
      end
    end
  end
  
  def department_calendar  
    @employees = if params[:department].present? 
      @department = Department.find(params[:department])
      Employee.where(:department_id => params[:department] )
    else
      Employee.all
    end    
    @group_employees = @employees.pluck(:group_id).uniq     
    @group_holiday_calender = HolidayCalender.where(:group_id => @group_employees).pluck(:event_id).uniq    
    @department_events = Event.where(:id => @group_holiday_calender)
    respond_to do |format| 
      format.html  
      format.js
      format.json do 
        render :json => @department_events.map { |event| {:title => event.event_name, :start => event.event_date.to_date} }
      end
    end
  end
    
  def department_leaves_calendar    
    @employees = if params[:department].present? 
      @department = Department.find(params[:department])
      Employee.where(:department_id => params[:department] )
    else
      Employee.all
    end    
    @department_leaves = LeaveHistory.where(:employee_id => @employees, :status => "APPROVED") 
    #raise @department_leaves.inspect
    respond_to do |format| 
      format.html 
      format.js    
      format.json do
        render :json =>  @department_leaves.map{|leave| {:title => leave.employee.full_name, :start => leave.from_date.to_date, :end => leave.to_date.to_date.tomorrow}}        
      end
    end          
  end            
  
  def company_leaves_calendar
    @all_leaves = LeaveHistory.all.where(:status => "APPROVED")
     respond_to do |format| 
      format.html  
      format.json do 
        render :json => @all_leaves.map { |leave| {:title => leave.employee.full_name, :start => leave.from_date.to_date , :end => leave.to_date.to_date.tomorrow} }
      end
    end       
  end
  
  def company_calendar   
    @all_holidays = Event.all
    #raise @all_holidays.inspect
    respond_to do |format| 
      format.html
      format.json do 
        render :json => @all_holidays.map { |event| {:title => event.event_name, :start => event.event_date.to_date} }
      end
    end       
  end
=end
end
