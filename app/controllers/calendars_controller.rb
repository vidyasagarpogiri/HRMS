# Author: Priyanka
# Calendar view for Leaves and Holidays
class CalendarsController < ApplicationController

  def reporting_manager_calendar 
    @reportee_employees = current_user.employee.reportees_employees
    @holidays = HolidayCalender.all.where(:group_id => current_user.employee.group_id)
    #raise @holidays.inspect       
  end
  
  def workgroup_calendar
    #@department_leaves = LeaveHisory.where(:department_id => 2)
    #raise @department_leaves.inspect
  end
  
  def department_calendar
    if params[:department_id].present?
      @department = Department.find(params[:department_id].to_i) 
      @employees = @department.employees
      @groups = @employees.map(&:group)
      @events = []
      @groups.each do |g|
        @events << g.events
      end 
     @events = @events.uniq!
    end
    @events = Event.all
  end
  
  def company_calendar
    @all_leaves = LeaveHistory.all.where(:status => "APPROVED")
    @all_holidays = Event.all
    #raise @all_holidays.inspect   
  end
end
