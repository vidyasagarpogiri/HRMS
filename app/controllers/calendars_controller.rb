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
          @department = Department.find(params[:department_id]) 
          @calendar_events = "/calendar.json?calendar_type=Department&department_id= #{params[:department_id]}"
          @department.employees
        else
          @calendar_events = '/calendar.json?calendar_type=Department'
          Employee.all
        end    
      @group_employees = @employees.pluck(:group_id).uniq     
      @all_holidays = HolidayCalender.where(:group_id => @group_employees).map(&:event).uniq    
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
          @employees = Employee.all
          @group_employees = @employees.pluck(:group_id).uniq     
          @all_holidays = HolidayCalender.where(:group_id => @group_employees).map(&:event).uniq  
          @employees
        end 
         
        @all_leaves = LeaveHistory.where(:employee_id => @employees, :status => "APPROVED") 
       
       #------------------------------------------------------------------------------------------------
      elsif calendar_type == "Workgroup"
        @employees = if params[:workgroup_id].present? 
            @workgroup = Workgroup.find(params[:workgroup_id])
            @calendar_events = "/calendar.json?calendar_type=Workgroup&workgroup_id= #{params[:workgroup_id]}"
            @workgroup.employees << Employee.find(@workgroup.admin_id)
            
          else
            @calendar_events = "/calendar.json?calendar_type=Workgroup"
            Employee.all
          end 
         # raise @employees.inspect
        @group_employees = @employees.pluck(:group_id).uniq     
        @all_holidays = HolidayCalender.where(:group_id => @group_employees).map(&:event).uniq  
        @all_leaves = LeaveHistory.where(:employee_id => @employees, :status => "APPROVED") 
       #raise @all_holidays.inspect 
      #---------------------------------------------------------------------------------------------------
      elsif calendar_type == "Reportees"
        @reportee_employees = current_user.employee.reportees_employees
        @reportee_employees_groups = @reportee_employees.pluck(:group_id).uniq    
        @all_holidays = HolidayCalender.where(:group_id => @reportee_employees_groups).map(&:event).uniq 
        @all_leaves = LeaveHistory.where(:employee_id => (@reportee_employees.pluck(:id)), :status => "APPROVED")
        @calendar_events = "/calendar.json?calendar_type=Reportees" 
      #---------------------------------------------------------------------------------------------------
    end
    else
       @all_holidays = Event.all
       @all_leaves = LeaveHistory.all.where(:status => "APPROVED")
  end
    response1 = @all_holidays.map { |event| {:title => event.event_name, :start => event.event_date.to_date}  }
    #raise @all_leaves.first.employee.full_name.inspect
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

end
